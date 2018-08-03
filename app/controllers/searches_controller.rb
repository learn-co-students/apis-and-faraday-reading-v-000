class SearchesController < ApplicationController
  def search
  end

  def foursquare
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "LVCHKQDD4NFURZ0LKNNAWEPEXFX103DHJRDQK13P5WKVSS53"
        req.params['client_secret'] = "M45A3KC5ZODWUMSBBPO5MTIEELN32RG535QL0DJLTJ3VPAXI"
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
      body_hash = JSON.parse(@resp.body)
      @venues = body_hash["response"]["venues"]
      render 'search'
    end
end
