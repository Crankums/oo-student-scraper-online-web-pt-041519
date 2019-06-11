require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = []
    html = open(index_url)
    text = Nokogiri::HTML(html)
    text.css('.roster-cards-container').each do |card|
      card.css('.student-card a').each do |profile|
        profile_url = "#{profile.attr('href')}"
        name = profile.css(".student-name").text
        location = profile.css(".student-location").text
        profiles << {name: name, location: location, profile_url: profile_url}
      end
    end
    # binding.pry
    profiles
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    text= Nokogiri::HTML(open(profile_url))
      pages = text.css(".social-icon-container").children.css("a").map {|icon| icon.attribute("href").value}
        pages.each do |icon|
        if icon.include?("twitter")
          hash[:twitter]= icon
        elsif icon.include?("linkedin")
          hash[:linkedin]= icon
        elsif icon.include?("github")
          hash[:github]= icon
        else
          hash[:blog]= icon
        end
        #binding.pry
          hash[:profile_quote] = text.css(".profile-quote").text if text.css(".profile-quote")
        hash[:bio] = text.css(".description-holder p").text if text.css(".description-holder p").text
      end
      hash
    end
end
