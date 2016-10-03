class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '5L240FZ41LU3XA0IHAM1THJHBK34AKQHEARBR5NZ31TKJMJI'
        req.params['client_secret'] = 'T1IOBNN5LST1UPXIREZM4U3TIUI520NW2KBOF0KA4VYENV0F'
        req.params['v'] = '20160201'
        req.params['m'] = 'foursquare'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0
      end

      body_hash = JSON.parse(resp.body)

      if resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end
end
