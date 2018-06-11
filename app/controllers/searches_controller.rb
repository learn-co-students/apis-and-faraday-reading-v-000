class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'MKSEAWFHNJLG2FIXPDRH4KLDMZZMRHHDRWGPHVTFC34LXSJT'
      req.params['client_secret'] = 'MZYAFN51I2OMQHTOBGE2YGOLVBDS3ZVLDPK54KSJUSAFVLHI'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body) 
    @venues = body_hash["response"]["venues"]

    render 'search'
  end
  
end
