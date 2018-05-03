class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'QS4V2GN2GCMVDDRHKI1JGKTLQZJA3PEMT4EFVATEVMJ1PKO5'
        req.params['client_secret'] = 'ZVSY2SBBBOUOMOYSQAFLD2RAK1JC2JW3UWCMH5ZKFDT21J3L'
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
      end

    render 'search'
  end
end
