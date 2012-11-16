require 'spec_helper'

describe User do
  let(:passwords) { YAML.load_file('config/passwords.yml') }
  let(:chronicler_password) { passwords["chronicler"] }
  let(:member_password) { passwords["family_member"] }

  describe 'auth' do
    subject { User.auth(role, password) }

    context 'chronicler' do
      let(:role) { :chronicler }

      context 'with the wrong password' do
        let(:password) { member_password  }
        it { should be false }
      end

      context 'with the right password' do
        let(:password) { chronicler_password }
        it { should be true }
      end
    end

    context 'family_member' do
      let(:role) { :family_member }

      context 'with the wrong password' do
        let(:password) { chronicler_password }
        it { should be false }
      end

      context 'with the right password' do
        let(:password) { member_password }
        it { should be true }
      end
    end
  end

  describe 'get' do
    subject { User.get(role) }

    context 'role is nil' do
      let(:role) { nil }
      its(:guest?) { should be true }
    end

    context 'role is member' do
      let(:role) { :member }
      its(:member?) { should be true }
    end

    context 'role is chronicler' do
      let(:role) { :chronicler }
      its(:chronicler?) { should be true }
    end
  end

  describe 'guest?, member?, chronicler?' do
    let(:user) { User.new(role) }

    context 'guest' do
      let(:role) { :guest }

      it { user.guest?.should be true }
      it { user.member?.should be false }
      it { user.chronicler?.should be false }
    end

    context 'member' do
      let(:role) { :member }

      it { user.guest?.should be false }
      it { user.member?.should be true }
      it { user.chronicler?.should be false }
    end

    context 'chronicler' do
      let(:role) { :chronicler }

      it { user.guest?.should be false }
      it { user.member?.should be false }
      it { user.chronicler?.should be true }
    end

  end
end
