require 'spec_helper'

describe 'WebCms' do
  let(:output_dir) { 'graphs' }
  before(:each) do
    if Dir.exist?(output_dir)
      FileUtils.rm_rf(File.join(output_dir, '.'))
    else
      FileUtils.mkdir output_dir
    end
  end

  after(:each) do
    FileUtils.rm_rf(File.join(output_dir, '.'))
  end

  it 'generates a file' do
    expect do
      WebCms('log/production.log')
    end.to change{Dir.entries(output_dir).size}.by(3)
  end

  it 'actually generates an image' do
    expect do
      WebCms('log/production.log')
    end.to change{Dir.glob(File.join(output_dir, '*.png')).size}.by(3)
  end
end
