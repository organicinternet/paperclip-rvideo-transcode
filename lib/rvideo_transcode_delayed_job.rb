require 'rvideo'

class RvideoTranscodeDelayedJob < Struct.new(:klass, :id)

  def perform
    instance = klass.constantize.find(id)
    instance.attachment.reprocess!
  end
  
end