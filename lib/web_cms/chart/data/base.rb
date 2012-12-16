module WebCms
  module Chart
    module Data
      class Base
        attr_reader :web_cms_data

        def initialize(web_cms_data)
          @web_cms_data = web_cms_data
        end

        def title
          ''
        end

        def chart_type
          'Line'
        end

        # @return [Hash] The hash's value is an Array with grouped frequencies
        # #=> { 'webcms' => [1, 2, 1] }
        def data
          {}
        end

        # @return [Array<String>] Elements will be used as labels
        # on the x-axis in the returned order
        # #=> ['0-99', '100-199', ...]
        def labels
          []
        end
      end
    end
  end
end

