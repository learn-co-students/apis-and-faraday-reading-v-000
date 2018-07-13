class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "DRWBWX1DEAIVFGUNBTH5J3XK325LHDOT0IRJEIK4D1UVR3TJ"
        req.params['client_secret'] = "IPB5LVRPFF3RB5VP0DSAEBCMH4BVH0ISDT5UKJU0PFCELT1C"
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 0
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

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end
