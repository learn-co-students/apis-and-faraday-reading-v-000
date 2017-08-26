class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'SDTVI1NEAV5K1EQLOUKMRZZXOTTW2Z4O4SL3FIXTMMXHBYM2'
        req.params['client_secret'] = '3T2ZLYC3E5GYQRUGCP312HH03WACI5IKPR415AHTOYNQPTDU'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
      if @resp.success?
        @venues = JSON.parse(@resp.body)['response']['venues']
      else
        @error = JSON.parse(@resp.body)['meta']['errorDetail']
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end

end
