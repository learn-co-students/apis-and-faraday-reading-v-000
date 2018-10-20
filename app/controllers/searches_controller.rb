class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'HS5SD5KGEO5NBHOTCO0KFWLGLCUETNSEFNDRG5FTFSQWJ02G'
      req.params['client_secret'] = 'SOCF5LSCJS0JQ11W2S1UU5FLC2C3TJYAVV5EGYJDVUZ0HRD2'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end
 
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
  render 'search'
  end
end
