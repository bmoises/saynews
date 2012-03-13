class Downloader
  attr_accessor :mech, :opts, :uri, :cached_file, :resume
  
  WORD_WRAP = 60
  
  def initialize(opts = {})
    @uri = opts[:uri]
    @mech = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }
  end


  def download  
    if !file_exists?
      puts "File does not exist: #{cached_file}"
      @mech.get(url) do |page|
        save!(parse(page.body))
      end
    end
  end
  
  def save_resume_point!(line)
    File.open(resume_point_file, "w") do |file|
      puts "#{cached_file}||#{line}"
      file.puts "#{cached_file}||#{line}"
    end
  end
  
  def delete_resume_point!
    FileUtils.rm resume_point_file 
  end
  
  def resume_point_file
    File.join(SAYNEWS_CACHE,"resume")
  end
  
  def resume_data
    begin
      @resume_data ||= File.open(resume_point_file).read.split("||")
    rescue
      @resume = false
    end
  end
  
  def url
    @uri
  end
  
  def parse(content)
    raise "Implement in your class"
  end
  
  def cached_file
    @cached_file ||= File.join(SAYNEWS_CACHE,Digest::MD5.hexdigest(url))
  end
  
  def file_exists?
    File.exists?(cached_file)
  end
  
  def read_file
    resume_from = resume_data && resume_data[1]
    File.open(cached_file).each_line do |line|
      if @resume && line != resume_from
        next
      else
        @resume = false # stop fastforward
      end
      save_resume_point!(line)
      yield line
    end
  end
  
  def save!(content)
    if !File.exists?(SAYNEWS_CACHE)
      FileUtils.mkdir_p SAYNEWS_CACHE
    end
    puts cached_file
    File.open(cached_file,'w') do |file|
      file.puts content
    end
  end
  
end