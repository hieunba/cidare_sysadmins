# InSpec test for recipe cidare_sysadmins::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

unless os.windows?
  describe user('cidare-user') do
    it { should exist }
  end

  describe directory('/home/cidare-user') do
    it { should exist }
  end

  describe directory('/home/cidare-user/.ssh') do
    it { should exist }
    its('mode') { should cmp '0700' }
  end

  describe file('/home/cidare-user/.ssh/authorized_keys') do
    it { should exist }
  end

  describe file('/etc/sudoers.d/cidare-user') do
    it { should exist }
    its('mode') { should cmp '0440' }
  end

end
