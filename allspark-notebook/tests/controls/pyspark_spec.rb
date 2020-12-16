title 'Working pyspark'

control "pyspark is available" do
  impact "high"
  title "pyspark should be installed and work"
  desc "pyspark installed and can run pyspark jobs"
  tag "pyspark"
  tag "spark"

  describe command("echo $SPARK_HOME") do
    its("stdout.strip") { should eq "/usr/local/spark" }
  end

  # Can run on of the spark examples
  describe command("python3 /usr/local/spark/examples/src/main/python/pi.py") do
    its("exit_status") { should eq 0 }
    # Pi calculated using Spark example job is very
    # approximate, once it returned 3.13###
    # so checking against 3.1 to avoid random failures
    its("stdout") { should match /Pi is roughly 3.1/ }
  end
end
