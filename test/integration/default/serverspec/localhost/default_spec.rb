# Encoding: UTF-8

require_relative '../spec_helper'

describe 'prime-8-buildserver::default' do

  describe '.cloud8 filesystem' do 
    describe file('/var/lib/jenkins/.cloud8') do 
      it { should be_directory }
      it { should be_owned_by 'jenkins' }
      it { should be_mode '0755' }
    end
    describe file('/var/lib/jenkins/.cloud8/creds') do 
      it { should be_directory }
      it { should be_owned_by 'jenkins' }
      it { should be_mode '0755' }
    end
    describe file('/var/lib/jenkins/.cloud8/repos') do 
      it { should be_directory }
      it { should be_owned_by 'jenkins' }
      it { should be_mode '0755' }
    end
    describe file('/var/lib/jenkins/.cloud8') do 
      it { should be_directory }
      it { should be_owned_by 'jenkins' }
      it { should be_mode '0755' }
    end
  end 
end
