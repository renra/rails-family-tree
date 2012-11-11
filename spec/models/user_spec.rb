require 'spec_helper'

describe User do
  let(:passwords) { YAML.load_file('config/passwords.yml') }
  let(:admin_password) { passwords["admin"] }
  let(:viewer_password) { passwords["viewer"] }

  describe 'auth' do
    subject { User.auth(role, password) }

    context 'admin' do
      let(:role) { :admin }

      context 'with the wrong password' do
        let(:password) { viewer_password  }
        it { should be false }
      end

      context 'with the right password' do
        let(:password) { admin_password }
        it { should be true }
      end
    end

    context 'viewer' do
      let(:role) { :viewer }

      context 'with the wrong password' do
        let(:password) { admin_password }
        it { should be false }
      end

      context 'with the right password' do
        let(:password) { viewer_password }
        it { should be true }
      end
    end
  end
end
