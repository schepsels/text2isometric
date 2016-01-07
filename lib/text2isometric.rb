require "text2isometric/version"
require 'ostruct'
require 'erb'

module Text2isometric
  class Commands < Thor
    class_option :color, :desc => 'text color css compatible, default black', :aliases => '-c', :type => :string
    class_option :size, :desc => 'text size in pixels, default 80', :aliases => '-s', :type => :numeric
    class_option :font, :desc => 'Font, default Arial', :aliases => '-f', :type => :string

    def initialize(*args)
      super
      @output_dir = File.expand_path('~') + "/isometric"
    end

    desc "version", "Display version"
    def version
      print Text2isometric::VERSION + "\n"
    end

    desc "instgrafflescript", "install omnigraffle applescript"
    def instgrafflescript
      script_path =  File.expand_path('../../templates/isometric-text.scpt',__FILE__)
      dest_path = File.expand_path('~') + "/Library/Scripts/Applications/OmniGraffle/"
      system "cp -v #{script_path} #{dest_path}"
    end

    desc "side TEXT", "Generate text in side"
    def side(text)
      create_isometric(text, 'side')
    end

    desc "plane TEXT", "Generate text in plane"
    def plane(text)
      create_isometric(text, 'plane')
    end

    desc "front TEXT", "Generate text in front"
    def front(text)
      create_isometric(text, 'front')
    end

    desc "top TEXT", "Generate text in top"
    def top(text)
      create_isometric(text, 'top')
    end

    desc "cube", "show cube with directions"
    def cube
      cube = <<CUBE
                 .......
             ....       ....
         ....               ....
     ....      t                ....
 ....              o                ...
|...                   p            ...|
|   ....                        ....   |
|       ....                ....       |
|           ....        ....           |
|   f           .... ...               |
|       r           |                  |
|          o        |         e        |
|             n     |       d          |
|                t  |     i            |
|                   |  s               |
......              |              ....          e
      .....         |         .....          n
           .....    |    .....          a
                ....|....          l
                    .         p


CUBE
      print cube
    end

    private

    def create_isometric(text, axis)
      system "rm -Rf #{@output_dir}"
      system "mkdir -p #{@output_dir}"

      r = {}
      if options[:size]
        r['size'] = options[:size]
      else
        r['size'] = '80'
      end

      unless options[:font].empty?
        r['color'] = options[:color]
      else
        r['color'] = 'black'
      end

      unless options[:font].empty?
        r['font'] = options[:font]
      else
        r['font'] = 'black'
      end

      r['text'] = text
      r['transform_class'] = axis

      erb_path =  File.expand_path('../../templates/text.html.erb',__FILE__)
      template = File.read(erb_path)
      namespace = OpenStruct.new(
        r:r
      )
      result = ERB.new(template).result(namespace.instance_eval { binding })
      File.open("#{@output_dir}/text.html", 'w') { |file| file.write(result)}

      #html -> png
      system "/usr/local/bin/webkit2png -F --transparent -o #{@output_dir}/out #{@output_dir}/text.html"
      system "/usr/local/bin/convert #{@output_dir}/out-full.png -define png:big-depth=16 -define png:color-type=6 -trim #{@output_dir}/trim.png"
      system "mv #{@output_dir}/trim.png #{@output_dir}/isometric.png"

      print "created:\n"
      print "#{@output_dir}/isometric.png\n"
    end
  end
end

