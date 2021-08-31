require 'spec_helper'
describe 'boundary' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with defaults for all parameters' do
        it { is_expected.to contain_class('boundary') }
        it { is_expected.to contain_anchor('boundary::begin').that_comes_before('Class[boundary::Install]') }
        it { is_expected.to contain_class('boundary::install').that_comes_before('Class[boundary::Config]') }
        it { is_expected.to contain_class('boundary::config').that_notifies('Class[boundary::Service]') }
        it { is_expected.to contain_class('boundary::service').that_comes_before('Anchor[boundary::end]') }
        it { is_expected.to contain_anchor('boundary::end') }
        it { is_expected.to contain_group('boundary') }
        it { is_expected.to contain_package('boundary') }
        it { is_expected.to contain_service('boundary') }
        it { is_expected.to contain_user('boundary') }
      end
    end
  end
end
