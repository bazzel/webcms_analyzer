module WebCms
  module Chart
    module Data
      class ExpectedVsRetrieved < Base
        def title
          'Number of retrieved CatalogItems'
        end

        def chart_type
          'Line'
        end

        def data
          {
            'expected' => @web_cms_data.map { |e| e[1] },
            'retrieved' => @web_cms_data.map { |e| e[0] }
          }
        end
      end
    end
  end
end

