class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "0NVMA1254BDK2EGDIUYQ0CD0BQQHZEMSLXHUOMPWHQUFH0RU"
      req.params['client_secret'] = "VSGO3UXLOCUXKHFRH2Y5HQM015U1CO4GIA4YJW1EE4HDPQ3F"
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
