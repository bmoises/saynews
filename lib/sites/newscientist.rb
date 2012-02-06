class Newscientist < Downloader
  
  def url
    u = super
    u+="?full=true&print=true"
  end
  
  def parse(content)
    res = []
    doc = Nokogiri::HTML(content)
    doc.css('#maincol p').each do |paragraph|
      res << paragraph.content.sentences
    end
    res.join("\n")
  end
end