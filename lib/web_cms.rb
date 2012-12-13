require File.join(File.dirname(__FILE__), './web_cms/builder.rb')

def WebCms(filename)
  WebCms::Builder.process(filename)
end


#class WebCms < Array
  #class << self
    #def analyze(file)
      #new(file).analyze
    #end
  #end

  #def initialize(filename)
    #extract_rows(filename).each { |row| self << numberify(row) }
    #self
  #end

  #def analyze
    #[header, aggregated_rows, nil].join("\n")
  #end

  #private
  ## Filters the content of filename for rows that contain
  ## the text 'expected'.
  ## returns [Array] Rows of the file that contain useful information
  ##  '[CatalogItem] Retrieved 10 products, expected 10 (500.3ms)'
  #def extract_rows(filename)
    #File.open(filename).grep(/expected/)
  #end

  #def aggregated_rows
    #categorized_array.map do |e|
      #k = e.first
      #v = e.last
      #["#{k}-#{k+99}", v].join("\t")
    #end
  #end

  #def categorized_array
    #h = Hash.new(0)
    #self.each do |e|
      #key = e.last / 100 * 100
      #h[key] += 1
    #end
    #h.sort
  #end

  ## Creates an array with headers
  ##
  ## @return [Array] Collection of strings
  #def header
    #%w(time #requests).join("\t")
  #end

  #def numberify(row)
    #scan = row.scan(/(\d+)\s|(\d+)\./).flatten.compact.map(&:to_i)
    #scan << scan[2]/scan[1]
    #scan
  #end

#end
