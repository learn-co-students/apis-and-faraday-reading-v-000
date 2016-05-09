class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "HXWAKZSCJVEP112U2TQTUITCKUCIBKK3E2NKFIMIXA0KKLC1"
      req.params['client_secret'] =  "VTBCKWDNXMAYBWVQDLFSQ4WDRWCL0OSD2MVUFQCSCCV2Z3W3"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      # req.options.timeout = 0
    end
      body = JSON.parse(@resp.body)
    if @resp.success?
        @venues = body["response"]["venues"]
    else
        @error = body["meta"]["errorDetail"]
    end

    rescue Faraday::TimeoutError
        @error = "There was a timeout. Please try again."
      render 'search'
    end
end
