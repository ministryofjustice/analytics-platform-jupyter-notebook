title 'Jupyter Lab'

control 'JupyerLab version' do
  impact 'high'
  title 'JupyterLab verioon'
  desc 'JupyerLab should be the correct verion'
  tag 'JupyterLab'

  describe command('jupyter-lab --version') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /3.4.7/ }
  end
end
