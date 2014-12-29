#!/usr/bin/env ruby

require 'fileutils'

startNumber = 2
endNumber   = 39
pathToBlog  = '../../blogs/iOS8-day-by-day/'
pathToBook  = 'manuscript'

(startNumber..endNumber).each do |n|
  puts "\n====Beginning pass #{n}====\n"
  n_string = n.to_s.rjust(2, "0")

  # 1. Copy the markdown file
  puts Dir.glob(File.join(pathToBlog, n_string + "*", n_string + "*.md"))
  md_locn = Dir.glob(File.join(pathToBlog, n_string + "*", n_string + "*.md")).first
  puts md_locn
  md_name = File.basename md_locn
  puts md_name
  md_dest = File.join(pathToBook, md_name)
  FileUtils.cp(md_locn, pathToBook)

  # 2. Copy the assets to images/xx
  assets_locn = Dir.glob(File.join(pathToBlog, n_string + "*", "assets")).first
  assets_dest = File.join(pathToBook, "images", n_string)
  FileUtils.cp_r(assets_locn, assets_dest)
  puts assets_locn
  puts assets_dest

  # 3. Replace references to new asset location
  text = File.read(md_dest)
  new_contents = text.gsub(/\(assets\//, "(images/#{n_string}/")
  File.open(md_dest, "w") {|file| file.puts new_contents }

  # 4. Add to Book.txt
  book_locn = File.join(pathToBook, "Book.txt")
  open(book_locn, 'a') { |f| f.puts md_name }

end