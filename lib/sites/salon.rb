class Salon < Downloader
  
  def url
    u = super
    u+="/print"
  end
  
  def parse(content)
    res = []
    doc = Nokogiri::HTML(content)
    doc.css('#entry-title-single').each do |title|
      res << title.content.sentences
    end

    doc.css('div.entryContent p').each do |paragraph|
      res << paragraph.content.sentences
    end
    res.join("\n")
  end
end
