require File.join(File.dirname(__FILE__), './data.rb')
require File.join(File.dirname(__FILE__), './chart/data/base.rb')
require File.join(File.dirname(__FILE__), './chart/data/request_time.rb')
require File.join(File.dirname(__FILE__), './chart/data/total_request_time.rb')
require File.join(File.dirname(__FILE__), './chart/data/expected_vs_retrieved.rb')
require File.join(File.dirname(__FILE__), './chart/generator.rb')

module WebCms
  class Builder
    attr_accessor :filename

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
      data = Data.new(@filename)
      # From here, list all the flavours
      # you'd like:
      chart_data = Chart::Data::RequestTime.new(data)
      Chart::Generator.generate(chart_data)
      chart_data = Chart::Data::ExpectedVsRetrieved.new(data)
      Chart::Generator.generate(chart_data)
      chart_data = Chart::Data::TotalRequestTime.new(data)
      Chart::Generator.generate(chart_data)
    end
  end
end

