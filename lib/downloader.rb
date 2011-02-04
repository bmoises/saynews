class Downloader
  attr_accessor :mech, :opts, :uri
  
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
  
  def url
    @uri
  end
  
  def parse(content)
    raise "Implement in your class biotch"
  end
  
  def cached_file
    File.join(SAYNEWS_CACHE,Digest::MD5.hexdigest(url))
  end
  
  def file_exists?
    File.exists?(cached_file)
  end
  
  def read_file
    File.open(cached_file).each_line do |line|
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