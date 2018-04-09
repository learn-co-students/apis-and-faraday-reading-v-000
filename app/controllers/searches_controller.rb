class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'O3C3OBZEKA2M2X1RIFKURAZ3LKVOOXWKN0U2TTPJP03VY4ME'
        req.params['client_secret'] = 'HNDOMGYTKNR5YURPMTZHONEF0KLY3IVY3D2V5QLELJ55CUAH'
        req.params['v'] = 20180323
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
    end
    render 'search'
  end
end
