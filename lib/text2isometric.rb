require "text2isometric/version"
require 'ostruct'
require 'erb'


module Text2isometric
  class Commands < Thor
    class_option :verbose, :desc => 'Be more verbose', :type => :boolean, :aliases => '-v'

    def initialize(*args)
      super
      @output_dir = "/tmp/test2isometric"
      #@verbose = true if options[:verbose]
    end

    desc "version", "Display version"
    def version
      print Text2isometric::VERSION + "\n"
    end

    desc "min30 TEXT", "Generate text in -30deg"
    def min30(name)

      print "Generating isometric text from: #{name}\n"

      #create html from template
      create_html(name)

      #html -> png
      system "webkit2png -F --transparent -o #{@output_dir}/out #{@output_dir}/text.html"
      system "mv #{@output_dir}/out-full.png #{@output_dir}/isometric.png"

      print "created:\n"
      print "#{@output_dir}/isometric.png\n"

    end

    private
    def create_html(name)
      system "rm -Rf #{@output_dir}"
      system "mkdir -p #{@output_dir}"

      r = {}
      r['text'] = name
      r['transform'] = '60deg,-30deg'

      erb_path =  File.expand_path('../../templates/text.html.erb',__FILE__)
      template = File.read(erb_path)
      namespace = OpenStruct.new(
        r:r
      )
      result = ERB.new(template).result(namespace.instance_eval { binding })
      File.open("#{@output_dir}/text.html", 'w') { |file| file.write(result)}
    end
  end
end

