require "text2isometric/version"
require 'ostruct'
require 'erb'

module Text2isometric
  class Commands < Thor
    class_option :verbose, :desc => 'Be more verbose', :type => :boolean, :aliases => '-v'

    def initialize(*args)
      super
      @output_dir = File.expand_path('~') + "/isometric"
      p __FILE__
      #@verbose = true if options[:verbose]
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

=begin
  desc "free TEXT", "Generate text in text value"
    def free(text)
      create_isometric(text, text)
    end
=end

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

    +--------+
   /        /|
  / t o p  / |e
 +--------+  d
 |        | i|    e
 | front  |s +   n
 |        | /  a
 |        |/  l
 +--------+ p
CUBE


      print cube
    end

    private

    def create_isometric(text, axis)
      system "rm -Rf #{@output_dir}"
      system "mkdir -p #{@output_dir}"

      r = {}
      r['text'] = text
      r['color'] = 'black'
      r['size'] = '80'
      r['font'] = 'Arial'
#      r['transform'] = axis_cmd
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

