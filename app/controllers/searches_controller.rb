class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '3TI0AUGWY1G3MAZ0ZAIZRH04YGZTX5AQ5MGMBFPRAHL0CDNJ'
      req.params['client_secret'] = 'FYCZOBSXTJSBHNX0RUGWZPAG5F3JWMVLAFIXVLGCWKJ0102R'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
   @venues = body_hash["response"]["venues"]
   render 'search'
    
  end
end
