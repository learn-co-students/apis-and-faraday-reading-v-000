class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get('https://api.foursquare.com/v2/venues/search') do |req|
        req.params['client_id'] = '51Y3PI1TGJZVUDO4GLDRZJKZHPZGU25FWI2JGDP3F1PINQ3L'
        req.params['client_secret'] = 'D1J5QG2QTYGA3OTCXXSJPFRLAJJL2HPY0JKZRILPLTOIBIFQ'
        req.params['v'] = '20180101'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
        body_hash = JSON.parse(@resp.body)
        if @resp.success?
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
