class Reader

  attr_accessor :done
  def initialize(downloader)
    @downlaoder = downloader
  end
  
  def read
    @downlaoder.read_file do |line|
      say(line)
      if @done
        say("You cancelled the reading")
        break
      end
    end
    output
  end
  
  def say(what_to_say)
    output = ""
     IO.popen("say", "w+") do |pipe|
       puts what_to_say
       pipe.puts what_to_say
       pipe.close_write  
       output = pipe.read
     end
     output
  end

end