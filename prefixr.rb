#!/usr/bin/env ruby

require 'open-uri'

prefixr_cli = {
   :version => '0.2',
   :description => 'This is a very tiny Ruby script that queries the prefixr.com API to prefix CSS3 properties for you.',
   :arguments => {
      '--help' => '',
      '-v / --version' => '',
      '--watch' => '',
      'Any .css files' => ''
   }
}

# Print the elements of an array
# format_list([1]) # '1'
# format_list([1,2]) # '1 and 2'
# format_list([1,2,3]) # '1, 2 and 3'

def format_list (list) 
   if (list.size == 1) then list.first
   else
      list[0...-1].join(', ') + ' and ' + list.last.to_s
   end
end

if ARGV.empty? or (ARGV.size == 1 and ARGV.first == '--help')
   print prefixr_cli[:description]
   puts " You are using version #{prefixr_cli[:version]}."
   puts 'How to use this script:'
   prefixr_cli[:arguments].each { |k, v|
      puts "#{k} # #{v}"
   }
   exit
end

if ARGV.size == 1 and (ARGV.first == '-v' or ARGV.first == '--version')
   puts prefixr_cli[:version]
   exit
end

watch = ARGV.delete '--watch' # `--watch` is not implemented yet.

not_existing_files = [] # contains the paths of the files that could not be found

oldCSS = ARGV.map { |path|
   if (!(File.exists?(path)))
      not_existing_files.push('"' + path + '"')
   else
      file = File.open(path)
      file.read
   end
}.join

if (not_existing_files.size > 0)
   tmp = 'file' + (not_existing_files.size == 1 ? '' : 's') # 'file' or 'files'?
   puts 'The ' + tmp + ' ' + format_list(not_existing_files) + ' could not be found.'
   exit
end

begin
   $file = open('http://prefixr.com/api/index.php?css=' + URI::encode(oldCSS))
rescue
   puts 'Either you are not connected to the internet or prefixr.com is down. Try checking your connection.'
else
   contents = $file.read
   puts contents
end