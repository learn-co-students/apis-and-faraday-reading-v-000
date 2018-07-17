require 'pry'
class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'SBLU4WY2SUQBSDKKBH3HFBBBCSAEULYTGQG3RVFBXZI1YFXS'
      req.params['client_secret'] = '3QRIRVN3RBPTNMOBMEN30HXH52PW5FSYKIBV31D2WEQRCMZS'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end

end
