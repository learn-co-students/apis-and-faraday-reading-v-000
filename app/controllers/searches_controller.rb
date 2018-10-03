class SearchesController < ApplicationController
  def search
  end

  def foursquare
     @resp =  Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'XEI0WE4UCB2GMGAZOEZLHFF4VHRCIITFKGNTLQHGCBPQ11P2'
      req.params['client_secret'] = '1J54RY2D3U2TSFDP5YZTUPVOW43UOZRSIF2ZX525QHEOWEZF'
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
