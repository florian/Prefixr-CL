#!/usr/bin/env ruby

require 'open-uri'

prefixr_cli = {
   :version => '0.1',
   :description => 'This is a very tiny Ruby script that queries the prefixr.com API to prefix CSS3 properties for you.',
   :arguments => {
      '$ prefixr --help' => 'Open this help.',
      '$ prefixr -v / --version' => 'Print the version number.',
      '$ prefixr styles.css' => 'Print the prefixed CSS in the Terminal.',
      '$ prefixr styles.css styles2.css' => 'You can specify as many CSS files as you want.',
      '$ prefixr styles.css > styles_prefixed.css' => 'Write the prefixed CSS in `styles_prefixed.css`'
   }
}

if ARGV.empty? or ARGV.first == '--help'
   print prefixr_cli[:description]
   puts " You are using version #{prefixr_cli[:version]}."
   puts 'How to use this script:'
   prefixr_cli[:arguments].each { |k, v|
      puts "#{k} # #{v}"
   }
   exit
end

if ARGV.size == 1 and ARGV.first == '-v' or ARGV.first == '--version'
   puts prefixr_cli[:version]
   exit
end

watch = ARGV.delete '--watch' # `--watch` is not implemented yet.

oldCSS = ARGV.map { |path|
   file = File.open(path)
   file.read
}.join

begin
   $file = open('http://prefixr.com/api/index.php?css=' + URI::encode(oldCSS))
rescue
   puts 'Either you are not connected to the internet or prefixr.com is down. Try checking your connection.'
else
   contents = $file.read
   puts contents
end