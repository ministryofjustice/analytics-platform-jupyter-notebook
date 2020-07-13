title 'Working Pip'

control 'CoPipnda available' do
  impact 1
  title 'Pip should be available to use'
  desc 'The Pip is preferred.'
  tag 'installer'
  tag 'pip'

  describe command('pip  --version') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /pip 20/ }
  end
end

control 'osmnx' do
  impact 1
  title 'Install osmnx'
  desc 'Data scientists should be able top use osmnx'
  tag 'installer'
  tag 'pip'

  describe command('pip install osmnx') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /Successfully installed/ }
  end
end
