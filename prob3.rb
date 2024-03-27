require 'httparty'

class WorldTime
  include HTTParty
  base_uri 'http://worldtimeapi.org/api/timezone'

  def initialize(area, location)
    @timezone = "#{area}/#{location}"
  end

  def fetch_time_data
    response = self.class.get("/#{@timezone}")
    JSON.parse(response.body)
  end

  def current_date_and_time
    time_data = fetch_time_data
    "#{time_data['timezone']} is #{time_data['datetime']}"
  end
end

area = 'Europe'
location = 'London'
world_time = WorldTime.new(area, location)
current_time = world_time.current_date_and_time

puts "The current time in #{current_time}"
