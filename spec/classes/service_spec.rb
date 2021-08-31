require 'spec_helper'
describe 'boundary' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with install_dir set to /opt/special and manage_service set to true and service_provider set to systemd' do
        let(:params) do
          {
            install_dir: '/opt/special',
            manage_service: true,
            service_name: 'boundary',
            service_provider: 'systemd',
          }
        end

        it { is_expected.to contain_systemd__Unit_file('boundary.service').with_content(%r{^ExecStart=/opt/special/boundary}) }
      end

      context 'with manage_service set to true' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'boundary',
          }
        end

        it { is_expected.to contain_service('boundary') }
      end

      context 'with manage_service set to false' do
        let(:params) do
          {
            manage_service: false,
            service_name: 'boundary',
          }
        end

        it { is_expected.not_to contain_service('boundary') }
      end

      context 'with package_name set to specialpackage and manage_service set to true' do
        let(:params) do
          {
            install_method: 'package',
            manage_service: true,
            package_name: 'specialpackage',
            service_name: 'boundary',
          }
        end

        it { is_expected.to contain_package('boundary').with_name('specialpackage') }
      end

      context 'with service_name set to specialservice' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'specialservice',
          }
        end

        it { is_expected.to contain_service('boundary').with_name('specialservice') }
      end

      context 'with service_name set to specialservice and with service_provider set to systemd' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'specialservice',
            service_provider: 'systemd',
          }
        end

        it { is_expected.to contain_service('boundary').with_name('specialservice') }
        it { is_expected.to contain_systemd__Unit_file('specialservice.service').that_comes_before('Service[boundary]').with_content(%r{^Description=specialservice}) }
      end

      context 'with service_name set to specialservice and with install_method set to package' do
        let(:params) do
          {
            install_method: 'package',
            manage_service: true,
            package_name: 'boundary',
            service_name: 'specialservice',
          }
        end

        it { is_expected.to contain_service('boundary').with_name('specialservice').that_subscribes_to('Package[boundary]') }
      end

      context 'with service_provider set to systemd' do
        let(:params) do
          {
            manage_service: true,
            service_name: 'boundary',
            service_provider: 'systemd',
          }
        end

        it { is_expected.not_to contain_file('boundary service file').with_path('/etc/init.d/boundary') }
        it { is_expected.to contain_systemd__Unit_file('boundary.service').that_comes_before('Service[boundary]') }
        it { is_expected.to contain_service('boundary') }
      end

      context 'with service_provider set to invalid' do
        let(:params) do
          {
            manage_service: true,
            service_provider: 'invalid',
          }
        end

        it { is_expected.to raise_error(%r{Service provider invalid not supported}) }
      end
    end
  end
end
