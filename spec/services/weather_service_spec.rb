require 'rails_helper'

RSpec.describe WeatherService do
  data = {
    'postal' => '10001',
    'lat' => 34.10,
    'lon' => 109.18
  }

  weather = [{}]

  let!(:cache) { Cache.create!(postal: data['postal'], data: { })}
  #todo
end