class NewYorker < Downloader
  
  def url
    u = super
    u+="?printable=true&currentPage=all"
  end
  
  def parse(content)
    res = []
    doc = Nokogiri::HTML(content)
    doc.css('div#articletext p').each do |paragraph|
      res << paragraph.content.wrap(WORD_WRAP)
    end
    res.join("\n")
  end
end