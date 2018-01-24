class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search/' do |req|
      req.params['client_id'] = 'SYHP2V5MXOIYXIU2GEJ0FFITESWPERQAJ40IPD5G2MJ3EQRF'
      req.params['client_secret'] = 'QA2H34AQZ0FXLPJM40XDZWE5IN0IKXCXJFTIO13SBJYKAL4J'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end
end
