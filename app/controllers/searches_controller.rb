class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'OOSNYACN0QJ4DRON0I13MGQ4KHGGNZTIPNRBMWWAZ2RQNFHP'
      req.params['client_secret'] = 'FSUW3MZ0DBGQJZMKC3HEYZ24JVK5SVACF3PQZZ2NR3JVUTSK'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'
  end
end
