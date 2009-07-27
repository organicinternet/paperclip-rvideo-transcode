require 'rvideo'
require 'delayed_job'

module Paperclip
 
  class RvideoTranscode < Processor
    
    attr_accessor :recipe
 
    def initialize(file, options = {}, attachment = nil)
      super
      @recipe             = options[:recipe]
      @current_format     = File.extname(file.path)
      @basename           = File.basename(file.path, @current_format)
    end
 
    def make
      unless @recipe.blank?
        dst = Tempfile.new([@basename, @format].compact.join("."))
        dst.binmode

        RVideo.logger = RAILS_DEFAULT_LOGGER
        rvideo_transcoder = RVideo::Transcoder.new
        rvideo_transcoder.execute(@recipe, {:input_file => file.path, :output_file => dst.path})
              
        dst
      else
        file
      end
    end
 
  end
 
end