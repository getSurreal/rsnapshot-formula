require 'serverspec'

# Required by serverspec
set :backend, :exec


describe package('rsnapshot') do
  it { should be_installed }
end

describe file('/etc/rsnapshot.conf') do
  it { should_not exist }
end

describe file('/etc/rsnapshot/conf.d/rsnapshot-web.conf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
end

describe file('/etc/rsnapshot/conf.d/rsnapshot-db.conf') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
