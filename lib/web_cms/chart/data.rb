module WebCms
  module Chart
    class Data
      attr_reader :web_cms_data

      def initialize(web_cms_data)
        @web_cms_data = web_cms_data
      end

      def title
        'Request Time'
      end

      def chart_type
        'SideBar'
      end

      # @return [Hash] The hash's value is an Array with grouped frequencies
      # #=> { 'webcms' => [1, 2, 1] }
      def data
        { 'webcms (ms./req. +/- 50ms.)' => categorized_array.map { |e| e.last } }
      end

      # @return [Array<String>] Elements will be used as labels
      # on the x-axis in the returned order
      # #=> ['0-99', '100-199', ...]
      def labels
        categorized_array.map do |e|
          k = e.first
          thousand_seperated(k+50)
        end
      end

      private
      # >> thousand_seperated(1234567)
      # => 1,234,567
      #
      # >> thousand_seperated(1234567, '.')
      # => 1.234.567
      def thousand_seperated(number, seperator = ',')
        number.to_s
          .reverse
          .gsub(/.{3}/, '\0'+seperator)
          .reverse
          .gsub(/^#{seperator}/, '') # When first character is a seperator, remove it
      end

      def categorized_array
        hash = Hash.new(0)
        @web_cms_data.each do |e|
          key = rounded(e)
          hash[key] += 1
        end
        hash.sort
      end

      # Rounds last element of array down to nearest 100
      # >> rounded([123, 456])
      # # => 400
      def rounded(e)
        time_per_item(e) / 100 * 100
      end

      def time_per_item(e)
        (e[2]/e[1]).to_i
      end
    end
  end
end
