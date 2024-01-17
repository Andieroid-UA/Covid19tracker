require 'nokogiri'
require 'open-uri'
require 'byebug'
require_relative 'country.rb'
require_relative 'state.rb'

module Scraper
    URL = "https://www.worldometers.info/coronavirus/country/us/"

    # extract usa info from page
    def self.extract_usa_data(doc)
        country_main = doc.css(".maincounter-number")
        usa_confirmed_cases = country_main[0].text.strip
        usa_deaths = country_main[1].text.strip
        usa_recovered = country_main[2].text.strip

        Country.new("USA", usa_confirmed_cases, usa_deaths, usa_recovered)
    end

    # extra states info from page
        def self.extract_states_data(doc)
            states_table = doc.css('tbody tr')

            states_table[1..51].each do |row|
                name = row.css('td')[1].text.strip
                cases = row.css('td')[2].text.strip
                deaths = row.css('td')[4].text.strip
                recoveries = row.css('td')[6].text.strip

                if(name != 'District of Columbia')
            State.new(name, cases, deaths, recoveries)
            end
        end
    end

    # scrape data
    def self.scrape_data
        puts "Scraping data..."
        unparsed_page = URI.open(URL)
        doc = Nokogiri::HTML(unparsed_page)
        extract_usa_data(doc)
        extract_states_data(doc)
    end
end