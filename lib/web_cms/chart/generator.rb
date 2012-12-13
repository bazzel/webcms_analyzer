module WebCms
  module Chart
    class Generator
      attr_accessor :web_cms_chart_data

      OUTPUT_DIR = 'graphs'

      class << self
        def generate(web_cms_chart_data)
          new(web_cms_chart_data).generate
        end

      end

      def initialize(web_cms_chart_data)
        @web_cms_chart_data = web_cms_chart_data
        ensure_output_directory
      end

      def generate
        output = File.join(OUTPUT_DIR, "#{basename}.png")
        File.open(output, 'w') { |f| f.write 'xyz' }
      end

      private
      def ensure_output_directory
        Dir.exist?(OUTPUT_DIR) || FileUtils.mkdir(OUTPUT_DIR)
      end

      # Sanitizes the data object's title
      # so it can be used as a basename for a file.
      #
      # >> '   Some   Title    '
      # => 'some_title'
      def basename
        @web_cms_chart_data.title
          .strip
          .gsub(/\s+/, '_')
          .downcase
      end
    end
  end
end

