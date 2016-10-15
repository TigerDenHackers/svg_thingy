require 'mini_magick'
require 'erb'
require 'sass'
require 'fileutils'

# swap hirbour.css into custom.css
begin
  template = File.read("main_template.scss.erb")
  customization = 'hirbour' # Used by template. =/
  b = binding
  css = ERB.new(template).result(b)
  puts css
  engine = Sass::Engine.new(css, syntax: :css)

  File.open('myStyle.css', 'w') do |f|
    f << engine.render
  end

  image = MiniMagick::Image.open("./our.svg")
  image.resize("200x200")
  image.density("1200")
  image.format("png")
  image.write("./our.png")
ensure
  FileUtils.rm('myStyle.css')
end
