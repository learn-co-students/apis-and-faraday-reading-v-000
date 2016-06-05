class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'ZNSTZDQFDV5WGJONZI4GZPONMNKRRERXVUTKHZBENI3HLX4O'
      req.params['client_secret'] = 'HH3IXHRODK0Y3ONNZZ2W4YT0JKVB4GYS2ILFP0GYDSSZ1ANS'
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
