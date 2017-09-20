class SearchesController < ApplicationController
  def search
  end

  def foursquare
     Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'E5YCZSLAIUSEUFCDZOKRYQZWQQOP1CZ2QH12LILFVSPUQZCW'
      req.params['client_secret'] = 'PTUNMLTTCUE3EV105A4K0UKBQHREN1QG142GM0EUDY1EDM0F'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    render 'search'
  end
end
