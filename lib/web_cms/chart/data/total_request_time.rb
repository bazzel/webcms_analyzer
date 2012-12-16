module WebCms
  module Chart
    module Data
      class TotalRequestTime < Base
        def title
          'Total Request Time'
        end

        def chart_type
          'Line'
        end

        def data
          { 'request time (s.)' => @web_cms_data.map { |e| e.last/1000 } }
        end
      end
    end
  end
end
