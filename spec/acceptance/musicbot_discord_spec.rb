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
      'software-properties-common',
      'build-essential',
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
end
