require 'rubygems'
require 'nokogiri'
require 'open-uri'

class CoolParser
  attr_accessor :url
  attr_accessor :path

  def initialize(new_url, new_path)
    @url  = new_url
    @path = new_path
  end

  def parse
    doc = Nokogiri::HTML(open(url))
    doc.xpath(path).drop(3).each_slice(3) do |tr|
      card = Card.new(original_text: tr[1].text, translated_text: tr[2].text)
      card.save
    end
  end
end
