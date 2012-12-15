module WebCms
  class Data < Array
    def initialize(filename)
      extract_rows(filename).each { |row| self << numberify(row) }
      self
    end

    private
    # Filters the content of filename for rows that contain
    # the text 'expected'.
    # returns [Array] Rows of the file that contain useful information
    #  '[CatalogItem] Retrieved 10 products, expected 10 (500.3ms)'
    def extract_rows(filename)
      File.open(filename).grep(/expected/)
    end

    # Transform each row to an Array containing 3 floating point numbers
    # >> numberify('[CatalogItem] Retrieved 10 products, expected 10 (500.3ms)')
    # => [10.0, 10.0, 500.3]
    def numberify(row)
      scan = row.scan(/(\d+)\s|(\d+\.\d)/).flatten.compact.map(&:to_f)
      scan
    end
  end
end
