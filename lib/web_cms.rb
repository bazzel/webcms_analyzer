require File.join(File.dirname(__FILE__), './web_cms/builder.rb')

def WebCms(filename)
  WebCms::Builder.process(filename)
end
