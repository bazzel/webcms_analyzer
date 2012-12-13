require 'spec_helper'

describe WebCms::Chart::Generator do
  subject { described_class }
  let(:output_dir) { 'graphs' }
  let(:title) { 'chart_title' }
  let(:web_cms_chart_data_stub) do
    double('web_cms_chart_data', {
      :title => title
    })
  end

  after(:each) do
    FileUtils.rm_rf(File.join(output_dir, '.'))
  end

  it 'generates an image' do
    expect do
      subject.generate web_cms_chart_data_stub
    end.to change{Dir.glob(File.join(output_dir, '*.png')).size}.by(1)
  end

  it 'uses title for filename' do
    expect do
      subject.generate web_cms_chart_data_stub
    end.to change{Dir.glob(File.join(output_dir, "#{title}.png")).size}.by(1)
  end

  it 'sanitizes the title' do
    exotic_name = '   Some   Exotic Name    '
    expected_name = 'some_exotic_name'
    web_cms_chart_data_stub.stub(:title).and_return(exotic_name)

    expect do
      subject.generate web_cms_chart_data_stub
    end.to change{Dir.glob(File.join(output_dir, "#{expected_name}.png")).size}.by(1)

  end
end
