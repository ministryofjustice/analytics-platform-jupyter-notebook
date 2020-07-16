title 'nano is available and default editor'

control 'nano available and default editor' do
  impact 'low'
  title 'nano is default editor'
  desc 'nano is a simple editor, it should be the default one'
  tag 'nano'
  tag 'editor'

  describe command('nano --version') do
    its('exit_status') { should eq 0 }
  end

  describe command('editor --version') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /GNU nano, version/ }
  end
end

