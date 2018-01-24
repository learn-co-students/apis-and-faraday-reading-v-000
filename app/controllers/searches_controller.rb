class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "M25UVTVQD053HHLXOAI32ILEF5SBH3JR21KMBGCYQS4NOUY2"
      req.params['client_secret'] = "YCY4D0PP0G3PLALSNOGVJYDQHFCPHZORAHX13AQI5XKMINCD"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end
  
end
