require 'daily_menu'
require 'json'

module DailyMenuApp
  class Fetcher
    def initialize(logger)
      @logger = logger
    end

    def fetch(location)
      menus = fetch_menus(location).map do |restaurant, entry|
        [restaurant.name, convert_entry(entry)]
      end
      Hash[menus]
    end

    def fetch_menus(location)
      DailyMenu.menus_for(location)
    rescue RuntimeError => e
      expectation = expectation_class_from(e).new(e.message)
      expectation.set_backtrace(e.backtrace)
      raise expectation
    end

    def convert_entry(entry)
      {
        menu: entry.content,
        date: entry.time.to_time.utc
      }
    end
    private :convert_entry

    def expectation_class_from(e)
      case e.message
      when /No configuration found/
        NotFound
      else
        RuntimeError
      end
    end
    private :expectation_class_from

  end
end
