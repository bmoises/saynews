class Newyorker < Downloader
  
  def url
    u = super
    u+="?printable=true&currentPage=all"
  end
  
  def parse(content)
    res = []
    doc = Nokogiri::HTML(content)
    doc.css('div#articletext p').each do |paragraph|
      res << paragraph.content.sentences
    end
    res.join("\n")
  end
end