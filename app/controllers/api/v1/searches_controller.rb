module Api
  module V1
    class SearchesController < ApplicationController
      def data
        resp = Geocoder.search(params[:address])

        d = WeatherService.call(resp.first.data)
        
        render json: { data: d, status: :ok}
      end
    end
  end
end