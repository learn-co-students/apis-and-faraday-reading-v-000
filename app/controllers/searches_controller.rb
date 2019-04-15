class SearchesController < ApplicationController
  def search
  end

  class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'JXR3WJBEHE4VZVIYVOLURJ2NSXARL2S032GKGFYAOAC5QWK4'
      req.params['client_secret'] = 'IW3ARKWM2SMFLOR4QITPZSPR1KM3IB0RE45C22BFCFWJ3KK1'
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

   rescue Faraday::ConnectionFailed
     @error = "There was a timeout. Please try again."
    render 'search'
  end
end
end
