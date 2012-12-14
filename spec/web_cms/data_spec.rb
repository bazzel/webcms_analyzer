require 'spec_helper'

describe WebCms::Data do
  subject { described_class.new(filename) }

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

  before(:each) do
    File.open(filename, 'w') { |f| f.write input }
  end

  after(:each) do
    File.delete filename
  end

  it 'returns an array with data' do
    subject.should == [
      [10, 10, 500.3],
      [10, 10, 1500.9],
      [10, 10, 2500.4],
      [10, 10, 1500.2]
    ]
  end


end
