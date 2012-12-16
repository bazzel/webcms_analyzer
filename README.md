# WebCms Analyzer

WebCms Analyzer parses a log file and generates a few graphs from some
specific lines that are located in the log file.

## Chart examples

![average_request_time](https://raw.github.com/bazzel/webcms_analyzer/master/graphs/average_request_time.png)

![number_of_retrieved_catalogitems](https://raw.github.com/bazzel/webcms_analyzer/master/graphs/number_of_retrieved_catalogitems.png)

![total_request_time]https://raw.github.com/bazzel/webcms_analyzer/master/(graphs/total_request_time.png)

## Prerequisites

WebCms Analyzer needs a log file. A suitable example can be found in
[log/production.log](log/production.log).
Lines that contain the following text will be parsed and turned into
data for the charts to be generated:

    [CatalogItem] Retrieved n products, expected m (tms)

## Installing WebCms Analyzer

    gem install bundler
    bundle install

## Run WebCms Analyzer
    ruby -r ./lib/web_cms -e "WebCms('path/to/your/logfile')"
