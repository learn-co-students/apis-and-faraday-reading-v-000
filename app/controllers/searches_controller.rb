class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'IQ0HZ4JSZ1BSTZGXJYACXZOD35BEJGTV5CMBAEUQOJ2YY5QK'
      req.params['client_secret'] = '2QF1VPFW5V2BPHK0ZOZH2BGJMKDFTKQH3F0KB3CPEKOUP3O5'
      req.params['v'] = '20160201'
      req.params['near'] #= params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end

end
