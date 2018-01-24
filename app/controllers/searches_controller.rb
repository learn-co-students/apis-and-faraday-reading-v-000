class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '0G31QPKMWTTCXYGF4SP2OQCUY3QIAWIACHSCKGFUKCYTJKBL'
        req.params['client_secret'] = '53DHJKWVETD4EGA0FJOEKVQSQZZUDJPTRMDIERPTWOF04T3R'
        req.params['v'] = '20160201'
        req.params['m'] = 'foursquare'
        req.params['near'] = params[:zipcode]
        req.params['query'] = "coffee shop"
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body['response']['venues']
      else
        @error = body['meta']['errorDetail']
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
