class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "4SGB4EAVTA5GHFLCZHLIFPHA5WONB1L4UIW4J0OJATSD23MN"
      req.params['client_secret'] = "31UYV4BKZRTPYFCX2B1DL2GIQ4PUGYT5MN1CKYMMW4DFKK1A"
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
     render 'search'
  end
end
