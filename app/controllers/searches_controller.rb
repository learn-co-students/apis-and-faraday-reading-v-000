class SearchesController < ApplicationController
  @@client_id = 'BGYBPONDSHZNVM42WWU343RTR1T4TZ2XNQJT52CLEYJL13N5'
  @@client_secret = '1TIHATF0J0FBVHCBS0PG2QXOCH2N4SH01AVQ30L1PO5YKD4E'

  def search
  end

  def foursquare
    Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = @@client_id
      req.params['client_secret'] = @@client_secret
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    render 'search'
  end
end
