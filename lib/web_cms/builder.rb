require File.join(File.dirname(__FILE__), './data.rb')
require File.join(File.dirname(__FILE__), './chart/data.rb')
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
      chart_data = Chart::Data.new(data)
      Chart::Generator.generate(chart_data)
    end
  end
end

