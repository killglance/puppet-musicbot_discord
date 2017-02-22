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
end
