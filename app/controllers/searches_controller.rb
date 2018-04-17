class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '53T0F4CFVHDTE5ZW2YKXXEO34VYPSOCRHOVWRAYOCVHWLW51'
      req.params['client_secret'] = 'FPLNVKG4S13IW5GLLYBTJJ43BHO1U3UQZED3HHRIMNDOLLZV'
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
