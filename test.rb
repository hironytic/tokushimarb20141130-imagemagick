require 'rubygems'
require 'RMagick'

# 読み込み
image = Magick::ImageList.new('image.png')

# 幅・高さ
puts "W:#{image.columns}, H:#{image.rows}."

# エッジ抽出 & 書き出し
image.edge(0).write('out.png')


# 各ピクセルのRGB値の検出
pixel = image.get_pixels(0, 0, 1, 1)[0]
red = 255 * pixel.red / Magick::QuantumRange
green = 255 * pixel.green / Magick::QuantumRange
blue = 255 * pixel.blue / Magick::QuantumRange
puts "R:#{red} G:#{green} B:#{blue}"


# 全ピクセル
image.each_pixel do |pixel, column, row|
  red = 255 * pixel.red / Magick::QuantumRange
  green = 255 * pixel.green / Magick::QuantumRange
  blue = 255 * pixel.blue / Magick::QuantumRange
  puts "(#{column}, #{row}) - R:#{red} G:#{green} B:#{blue}"
end
