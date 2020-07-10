title 'Working Conda'

control 'Conda not available' do
  impact 0
  title 'Conda installer not should be available to use'
  desc 'The Conda installer is not preferred, but is the only way to install some packages.'
  tag 'installer'
  tag 'conda'
  tag 'broken'

  describe command('conda info') do
    its('exit_status') { should eq 1 }
  end
end

control 'Conda install' do
  impact 0
  title 'Conda shoud be broken'
  desc 'Conda should not be able to install simple packages'
  tag 'installer'
  tag 'conda'
  tag 'broken'

  describe command('conda install -c anaconda libffi-3.3') do
    its('exit_status') { should eq 1 }
  end
end
