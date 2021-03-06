require 'spec_helper'

describe 'kafka', type: :class do
  let :facts do
    {
      osfamily: 'Debian',
      os: { family: 'Debian' },
      operatingsystem: 'Ubuntu',
      operatingsystemrelease: '14.04',
      lsbdistcodename: 'trusty',
      architecture: 'amd64',
      service_provider: 'upstart'
    }
  end

  it { is_expected.to contain_class('kafka::params') }

  context 'on Debian' do
    describe 'kafka' do
      context 'defaults' do
        it { is_expected.to contain_group('kafka') }
        it { is_expected.to contain_user('kafka') }

        it { is_expected.to contain_file('/var/tmp/kafka') }
        it { is_expected.to contain_file('/opt/kafka-2.12-2.4.1') }
        it { is_expected.to contain_file('/opt/kafka') }
        it { is_expected.to contain_file('/opt/kafka/config') }
        it { is_expected.to contain_file('/var/log/kafka') }
      end
    end
  end

  context 'on Debian' do
    describe 'kafka' do
      context 'all (compatible) parameters' do
        let :params do
          {
            version: '0.10.0.1',
            scala_version: '2.13',
            install_dir: '/usr/local/kafka',
            user_id: 9092,
            group_id: 9092,
            user: 'mykafka',
            group: 'mykafka',
            install_java: false,
            config_dir: '/opt/kafka/custom_config',
            log_dir: '/var/log/custom_kafka'
          }
        end

        it { is_expected.to contain_group('mykafka').with(gid: 9092) }
        it { is_expected.to contain_user('mykafka').with(uid: 9092) }

        it { is_expected.to contain_file('/var/tmp/kafka') }
        it { is_expected.to contain_file('/opt/kafka') }
        it { is_expected.to contain_file('/usr/local/kafka') }
        it { is_expected.to contain_file('/opt/kafka/custom_config') }
        it { is_expected.to contain_file('/var/log/custom_kafka') }
      end
    end
  end
end
