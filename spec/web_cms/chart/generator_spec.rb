require 'spec_helper'

describe WebCms::Chart::Generator do
  subject { described_class }
  let(:output_dir) { 'graphs' }
  let(:title) { 'chart_title' }
  let(:data) do
    {
      'foo' => [1,2,3,4],
      'bar' => [5,6,7,8]
    }
  end
  let(:labels) { ['I', 'II', 'III', 'IV'] }
  let(:chart_data_stub) do
    double('chart_data', {
      :title  => title,
      :data   => data,
      :labels => labels
    })
  end

  after(:each) do
    FileUtils.rm_rf(File.join(output_dir, '.'))
  end

  it 'generates an image' do
    expect do
      subject.generate chart_data_stub
    end.to change{Dir.glob(File.join(output_dir, '*.png')).size}.by(1)
  end

  it 'uses title for filename' do
    expect do
      subject.generate chart_data_stub
    end.to change{Dir.glob(File.join(output_dir, "#{title}.png")).size}.by(1)
  end

  it 'sanitizes the title' do
    exotic_name = '   Some   Exotic Name    '
    expected_name = 'some_exotic_name'
    chart_data_stub.stub(:title).and_return(exotic_name)

    expect do
      subject.generate chart_data_stub
    end.to change{Dir.glob(File.join(output_dir, "#{expected_name}.png")).size}.by(1)
  end

  describe 'Gruff' do
    let(:gruff_stub) { double.as_null_object }

    before(:each) do
      Gruff::SideBar.stub(:new).and_return(gruff_stub)
    end

    it 'create a Gruff Bar chart and saves it to disk' do
      Gruff::SideBar.should_receive(:new).and_return(gruff_stub)
      gruff_stub.should_receive(:write).with(File.join(output_dir, "#{title}.png"))

      subject.generate chart_data_stub
    end

    it 'uses title for Graph title' do
      gruff_stub.should_receive(:title=).with(title)
      subject.generate chart_data_stub
    end

    it 'uses data to populate graph' do
      gruff_stub.should_receive(:data).with('foo', [1,2,3,4])
      gruff_stub.should_receive(:data).with('bar', [5,6,7,8])
      subject.generate chart_data_stub
    end

    it 'uses labels for... well... the labels' do
      gruff_stub.should_receive(:labels=).with({
        0 => 'I',
        1 => 'II',
        2 => 'III',
        3 => 'IV'
      })
      subject.generate chart_data_stub
    end
  end
end
