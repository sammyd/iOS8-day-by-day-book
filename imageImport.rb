#!/usr/bin/env ruby

require 'fileutils'

startNumber = 2
endNumber   = 39
pathToBlog  = '../../blogs/iOS8-day-by-day/'
pathToBook  = 'manuscript'

(startNumber..endNumber).each do |n|
  puts "\n====Beginning pass #{n}====\n"
  n_string = n.to_s.rjust(2, "0")

  # 2. Copy the assets to images/xx
  assets_locn = Dir.glob(File.join(pathToBlog, n_string + "*", "original_assets")).first
  assets_dest = File.join(pathToBook, "images", n_string)
  FileUtils.cp_r(assets_locn, assets_dest)
  Dir[File.join(assets_dest, "*.png")].each do |img|
    puts img
    `convert -units PixelsPerInch #{img} -density 300 #{img}`
  end

end