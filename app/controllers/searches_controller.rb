class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "AFI0JQI2Z0ZLZXHNE1BGW1N1OCZWLTYHUFVRAZFYO3ZUYGPS"
        req.params['client_secret'] = 'S2C4J4TNEXIVQ1ITQXL5YGEETOOUE3ZBQI03TDSJHH3UO2NN'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end
    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
