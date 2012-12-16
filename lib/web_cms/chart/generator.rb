require 'gruff'
require 'fileutils'

module WebCms
  module Chart
    class Generator
      attr_accessor :chart_data

      OUTPUT_DIR = 'graphs'

      class << self
        def generate(chart_data)
          new(chart_data).generate
        end
      end

      def initialize(chart_data)
        @chart_data = chart_data
        ensure_output_directory
      end

      def generate
        graph.title = title
        populate_graph
        format_graph
        graph.minimum_value = 0
        begin
        graph.hide_dots = true
        rescue
        end
        graph.labels = labels
        write output
      end

      private
      def write(output)
        puts "[%s] Saving %s" % [self.class, output.inspect]
        graph.write output
      end

      def graph
        @graph ||= Gruff.const_get(chart_type).new(1200)
      end

      def chart_type
        @chart_data.chart_type
      end

      def populate_graph
        data.each { |k, v| graph.data k, v }
      end

      def format_graph
        graph.title_font_size = 12.0
        graph.legend_font_size = 10.0
        graph.marker_font_size = 8.0
      end

      def data
        @chart_data.data
      end

      def title
        @chart_data.title
      end

      # Transforms an Array of labels into
      # an indexed Hash
      #
      # >> ['I', 'II', 'III', 'IV']
      # #=> { 0 => 'I', 1 => 'II', 2 => 'III', 3 => 'IV' }
      def labels
        # Although there is this one liner,
        # I feel more comfortable with more descriptive code :)
        # @chart_data.labels.to_enum(:each_with_index).inject({}) {|h, (v,k)| h[k]=v;h}
        hash = Hash.new
        @chart_data.labels.each_with_index do |item, index|
          hash[index] = item
        end
        hash
      end

      def ensure_output_directory
        Dir.exist?(OUTPUT_DIR) || FileUtils.mkdir(OUTPUT_DIR)
      end

      def output
        File.join(OUTPUT_DIR, "#{basename}.png")
      end

      # Sanitizes the data object's title
      # so it can be used as a basename for a file.
      #
      # >> '   Some   Title    '
      # #=> 'some_title'
      def basename
        @chart_data.title
          .strip
          .gsub(/\s+/, '_')
          .downcase
      end
    end
  end
end

