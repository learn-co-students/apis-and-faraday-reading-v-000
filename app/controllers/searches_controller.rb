class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'DFZYVI2V52JDIAEIJZTNYVSAOE2BLBVW1DM2EIVRRTLETTV3'
        req.params['client_secret'] = '0BWPCQ20BCXVPUU1ZBSVC0HWWJW3EBCLKHAQSA1XRJWEJRKQ'
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
        @error = "The was a timeout. Please try again."
    end
    render 'search'
  end

end
