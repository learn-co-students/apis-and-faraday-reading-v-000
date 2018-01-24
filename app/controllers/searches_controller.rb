class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'PZHY3STBN1SABJSIM3QWVF3CREZKXBOOAUHMWPQYSUAB2FL3'
      req.params['client_secret'] = 'YSEIE4ML1TG0LOODAMGS122F1YL5YRWTQ1C5J3GZFQPI1RNT'
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
