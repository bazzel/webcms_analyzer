require File.join(File.dirname(__FILE__), './data.rb')
Dir[File.join(File.dirname(__FILE__), 'chart', 'data', '*.rb')].each {|file| require file }
require File.join(File.dirname(__FILE__), './chart/generator.rb')

module WebCms
  class Builder
    attr_accessor :filename
    attr_accessor :data

    class << self
      def process(filename)
        web_cms = new(filename)
        web_cms.process
      end
    end

    def initialize(filename)
      @filename = filename
    end

    def process
      process_chart 'RequestTime'
      process_chart 'ExpectedVsRetrieved'
      process_chart 'TotalRequestTime'
    end

    def data
      @data ||= Data.new(@filename)
    end

    private
    def process_chart(chart_type)
      chart_data = chart_data(chart_type)
      Chart::Generator.generate(chart_data)
    end

    # Suppose I should create a Factory class for this...
    def chart_data(chart_type)
      Chart::Data.const_get(chart_type).new(data)
    end
  end
end

