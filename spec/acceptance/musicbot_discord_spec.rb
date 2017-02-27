require 'spec_helper_acceptance'

describe 'musicbot_discord' do
  let(:manifest) {
    <<-END
class { 'musicbot_discord': }
    END
  }

  it 'should run without errors' do
    result = apply_manifest(manifest, :catch_failures => true)
    expect(@result.exit_code).to eq 2
  end
  it 'should be idempotent' do
    result = apply_manifest(manifest, :catch_failures => true)
    expect(@result.exit_code).to eq 0
  end

  [
      'build-essential',
      'ffmpeg',
      'git',
      'libopus-dev',
      'libffi-dev',
      'libsodium-dev',
      'unzip',
  ].each do |pkg|
    describe package(pkg) do
      it { is_expected.to be_installed }
    end
  end

  [
      'ppa:fkrull/deadsnakes',
      'ppa:mc3man/trusty-media',
      'ppa:chris-lea/libsodium',
  ].each do |repo|
    describe ppa(repo) do
      it { should be_enabled }
    end
  end

  describe user('musicbot') do
    it { should exist }
  end

  describe file('/opt/musicbot') do
    it do
      should be_directory
      should be_owned_by 'musicbot'
    end
  end
end
