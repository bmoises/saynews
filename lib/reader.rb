class Reader

  attr_accessor :done, :count
  def initialize(downloader)
    @downlaoder = downloader
    @count = 0
  end
  
  def read
    @downlaoder.read_file do |line|
      say(line)
      if stop?
        say("You cancelled the reading")
        break
      end
    end
  end
  
  def stop?
    @done ? true : false
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