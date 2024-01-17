class State

    attr_accessor :name, :confirmed_cases, :overall_deaths, :recoveries

    @@states = []

    def initialize(name, confirmed_cases, overall_deaths, recoveries)
        @name = name
        @confirmed_cases = confirmed_cases
        @overall_deaths = overall_deaths
        @recoveries = recoveries
        @@states << self
    end

    def self.all
        @@states
    end

    def self.first
        @@states[0]
    end

end