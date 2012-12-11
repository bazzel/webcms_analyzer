require 'spec_helper'

describe WebCms do
  subject { described_class.analyze(filename) }

  let(:filename)  { 'log/x.log' }
  let(:input) do
    <<-TXT
Some unimportant log statement
[CatalogItem] Retrieved 10 products, expected 10 (500.3ms)
Some unimportant log statement
[CatalogItem] Retrieved 10 products, expected 10 (1500.9ms)
Some unimportant log statement
[CatalogItem] Retrieved 10 products, expected 10 (2500.4ms)
Some unimportant log statement
[CatalogItem] Retrieved 10 products, expected 10 (1500.2ms)
    TXT
  end
  let(:expected_output) do
    <<-TXT
time\t#requests
0-99\t1
100-199\t2
200-299\t1
    TXT
  end

  before(:each) do
    File.open(filename, 'w') { |f| f.write input }
  end

  after(:each) do
    File.delete filename
  end

  it { subject.should == expected_output }

  it 'has 4 items' do
    described_class.new(filename).should have(4).items
  end

  it 'transforms every valuable row into data' do
    described_class.new(filename)[0].should == [10, 10, 500, 50]
    described_class.new(filename)[1].should == [10, 10, 1500, 150]
    described_class.new(filename)[2].should == [10, 10, 2500, 250]
    described_class.new(filename)[3].should == [10, 10, 1500, 150]
  end
end
