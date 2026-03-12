import os
import subprocess
import time
import boto3

# Third-party
import structlog
    return False


def authenticate_ecr_for_helm():
    """
    Authenticate Helm with ECR for OCI registry access.
    Uses boto3 to get ECR authorization token and logs into the registry.
    """
    if not getattr(settings, 'HELM_USE_OCI', False):
        # Skip ECR auth if not using OCI
        return

    try:
        # Get ECR registry URL from settings
        ecr_registry = getattr(settings, 'ECR_REGISTRY', None)
        if not ecr_registry:
            log.warning("ECR_REGISTRY not configured, skipping ECR authentication")
            return

        region = getattr(settings, 'AWS_DEFAULT_REGION', 'eu-west-2')

        # Get ECR authorization token
        ecr_client = boto3.client('ecr', region_name=region)
        response = ecr_client.get_authorization_token()

        auth_data = response['authorizationData'][0]
        token = auth_data['authorizationToken']
        registry_url = auth_data['proxyEndpoint'].replace('https://', '')

        # Decode the token (it's base64 encoded "AWS:password")
        import base64
        decoded = base64.b64decode(token).decode('utf-8')
        username, password = decoded.split(':', 1)

        # Login to ECR with helm registry
        log.info(f"Authenticating Helm with ECR registry: {registry_url}")
        proc = subprocess.Popen(
            ['helm', 'registry', 'login', registry_url, '--username', username, '--password-stdin'],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            encoding='utf8'
        )
        stdout, stderr = proc.communicate(input=password)

        if proc.returncode != 0:
            log.error(f"ECR authentication failed: {stderr}")
            raise HelmError(f"Failed to authenticate with ECR: {stderr}")

        log.info("Successfully authenticated Helm with ECR")

    except Exception as ex:
        log.error(f"Error during ECR authentication: {ex}")
        raise HelmError(f"ECR authentication error: {ex}")


def update_helm_repository(force=False):
    """
    Updates the helm repository and returns a dictionary representation of
    all the available charts.

    For OCI registries, authenticates with ECR instead of using helm repo update.
    """
    if getattr(settings, 'HELM_USE_OCI', False):
        # OCI doesn't use helm repo update, just authenticate with ECR
        authenticate_ecr_for_helm()
        return

    # Traditional HTTP-based helm repo
    repo_path = get_repo_path()
    # If there's no helm repository cache, call helm repo update to fill it.
    if not os.path.exists(repo_path):
    return chart


def upgrade_release(release, chart, *args, chart_version=None):
    """
    Upgrade to a new release version (for an app - e.g. RStudio).

    For OCI charts, chart should be the full OCI URL without version.
    chart_version is required for OCI charts.

    Returns the process for further processing by the caller.
    """
    update_helm_repository()

    # Build the helm command
    helm_args = [
        "upgrade",
        "--install",
        "--force",
        "7m0s",
        release,
        chart,
    ]

    # Add version for OCI charts (required for OCI)
    if getattr(settings, 'HELM_USE_OCI', False) and chart_version:
        helm_args.extend(["--version", chart_version])

    # Add any additional args passed in
    helm_args.extend(args)

    return _execute(*helm_args)


def delete(namespace, *args, dry_run=False):
    """
    Delete helm charts identified by the content of the args list in the
    referenced namespace. Helm 3 version.

    This command blocks, so the old charts are deleted BEFORE the new charts
    are installed. Will block for a maximum of settings.HELM_DELETE_TIMEOUT
    seconds.

    Logs the stdout result of the command.
    """
    if not namespace:
        raise ValueError("Cannot proceed: a namespace needed for removal of release.")
    proc = _execute(
        "uninstall",
        *args,
        "--namespace",
        namespace,
        "--wait",
        "--timeout",
        settings.HELM_DELETE_TIMEOUT,
        dry_run=dry_run,
    )
    if proc:
        stdout = proc.stdout.read()
        log.info(stdout)


def get_chart_app_version(chart_name, chart_version):
    """
    Returns the "appVersion" metadata for the helm chart with the referenced
    name and version.

    Returns None if there's no match or if the match is missing the
    "appVersion" metadata.
    """

    entries = get_helm_entries()
    chart_at_version = get_chart_version_info(entries, chart_name, chart_version)
    if chart_at_version:
        return chart_at_version.app_version
    else:
        return None
    