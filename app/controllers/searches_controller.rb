class SearchesController < ApplicationController
  def search
  end

  def foursquare
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "VTPEO3OEU2102RUVBVEBJRCPW0EVT40LC5UOGBGKEONLCCEE"
        req.params['client_secret'] = "EIXSJHMUETCRTD2LVD1BFBMCGA5VHXNAA4KKEGRLDWBFE4U0"
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

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
      render 'search'
  end
end
