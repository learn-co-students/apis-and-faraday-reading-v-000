class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'NOOGHWXMRTBIMDFM11YF2RBR2CAZ5MRWKFDFRH3J0SOUX3RM'
      req.params['client_secret'] = '0BZ2CZ0CXHCIRKFZCJMQBVHZBH2G1R4Z0N2HMYLJE2JKBLTX'
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
