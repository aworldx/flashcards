require 'rubygems'
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("http://1000mostcommonwords.com/1000-most-common-german-words/"))
doc.xpath('//article[@id="post-188"]//table//tr/td').drop(3).each_slice(3) do |tr|
  card = Card.new(:original_text => tr[1].text, :translated_text => tr[2].text)
  card.save
end
