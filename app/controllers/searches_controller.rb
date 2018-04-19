class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'J4DV1RREY4TPB4SJDEC445CEG4SZ1WNPTPT15UEEZAAEKKM3'
        req.params['client_secret'] = 'RQSVMVGDOOYFT1T2UCKRIVIO1KI2D0DHL1BOAT3P3ROJAAGV'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end
    rescue Faraday::ConnectionFailed
      @error = 'There was a timout. Please try again.'
    end
    render 'search'
  end
end
