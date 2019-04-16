class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "OZTD1GQ0T4ZFD5O3OPVQVLX4DDUPKTZGF1LUTXWX1RZYPQF5"
      req.params['client_secret'] = "DUZAJWMQXAHDWWOIV41Y15LXDQFOJWJG0FNATDBZCDFMNBPB"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end
end
