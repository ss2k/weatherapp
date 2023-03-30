require 'rails_helper'

RSpec.describe WeatherService do
  data = {
    'address' => {
      'postcode' => '10001'
    },
    'lat' => 34.10,
    'lon' => 109.18
  }

  weather_json = {
    'address' => { 'postcode' => '78701' }, 
    'weather' => [{'main' => 'Snowy'}],
    'main' => {
      'temp' => 27,
      'temp_min' => 15,
      'temp_max' => 30
    }
  }

  let!(:cache) { Cache.create!(postal: data['address']['postcode'], data: {'min' => 32 }) }

  describe '#call' do
    it 'will go to the cache if postal exists' do
      expect(Cache).to receive(:check_for_recent).with('10001')
      
      WeatherService.call(data)
    end

    it 'returns cache true if postal exists in the cache' do
      # just so it returns within the last 30 minutes updated
      cache.updated_at = Time.now
      cache.save!

      expect(WeatherService.call(data)).to eq ({
        'min' => 32,
        'cache' => true
      })
    end

    it 'calls the api if postal is not cached' do
      # update cache postal so it does not appear
      cache.update!(postal: '80924')
      
      response = OpenStruct.new
      response.body = weather_json.to_json

      allow(HTTParty).to receive(:get).and_return(response)

      formatted_response = {
        "weather"=>"Snowy", 
        "temp"=>27, 
        "min"=>15, 
        "max"=>30
      }

      expect(WeatherService.call(data)).to eq (formatted_response.merge('cache' => false))

      expect(Cache.last.postal).to eq '10001'
      expect(Cache.last.data).to eq formatted_response
    end
  end  
end