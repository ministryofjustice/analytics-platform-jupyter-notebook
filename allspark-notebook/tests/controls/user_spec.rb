title 'Jovyan User'

control 'Common Users' do
  impact 'high'
  title 'The jovyan user should exist'
  desc 'The joyvan user should exist and should have a UID of 1000'
  tag 'user'
  tag 'group'

  describe user('jovyan') do
    it { should exist }
    its('uid') { should eq 1000 }
  end
end

control 'Common Groups' do
  impact 'high'
  title 'The joyvan user should have the corect groups'
  desc 'joyvan should have the primary group of users and also be in the staff group to match RStudio, but not break this image'

  describe user('jovyan') do
    its('gid') { should eq 100 }
    its('groups') { should eq ['users', 'staff']}
  end
end
