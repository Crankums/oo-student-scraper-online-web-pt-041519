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
    hash = {} #create the container
    text= Nokogiri::HTML(open(profile_url)) #tell Nokogiri what to comb. We can remove a line by opening where the arg is passed in
      pages = text.css(".social-icon-container").children.css("a").map {|icon| icon.attribute("href").value}
        #specifically, we look at the children of social-icon-container and collect a specific value of an attrib into an array
        # the ".value" at the end keeps the whole "href" pairing from being returned.
        pages.each do |icon|
          #we iterate that array and use the conditionals set below to populate the hash
        if icon.include?("twitter")
          #the conditionals make the hash populate with or without the desired elements
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
        #these will populate regardless, so that if key-value pairs are missing, the hash will still return non-empty
      end
      hash
      #most importantly, the hash is returned
    end
end
