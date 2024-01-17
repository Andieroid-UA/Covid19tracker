class Country

    attr_accessor :name, :confirmed_cases, :overall_deaths, :recoveries

    @@countries = []

    def initialize(name, confirmed_cases, overall_deaths, recoveries)
        @name = name
        @confirmed_cases = confirmed_cases
        @overall_deaths = overall_deaths
        @recoveries = recoveries
        @@countries << self
    end

    def self.all
        @@countries
    end

    def self.first
        @@countries[0]
    end

end

