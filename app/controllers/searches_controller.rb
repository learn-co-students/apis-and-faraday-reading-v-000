class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = JMOCCDXVXU4WJHAUT55WEYQEHU42E25TFZBPM1EV53WLHTL0
      req.params['client_secret'] = LAX425VI4USOPNXRECWXEVMWBUMUY3IBORZKZYL14YXFTHI3
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
