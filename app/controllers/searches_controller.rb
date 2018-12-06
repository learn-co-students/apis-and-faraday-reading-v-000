class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'HQ5UOYPOREGXYHBDOFTUKMV0C0YE0NVL1P1QM0DDEYJQZGT5'
        req.params['client_secret'] = 'ZQGJQBNSRATUOWJEWOEGY3POIJO41HHXNWJFRV3V1EOQHS2D'
        req.params['v'] = '20150201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body['response']['venues']
      else
        @error = body['meta']['errorDetail']
      end

    rescue Faraday::ConnectionFailed
      @error = 'There was a timeout. Please try again.'
    end
    render 'search'
  end
end
