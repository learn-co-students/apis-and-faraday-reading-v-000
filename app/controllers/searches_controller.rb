class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '5b1acfc6db04f513b5dad3ba'
        req.params['client_secret'] = 2
        req.params['v'] = '20180522'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 0
      end

      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body['response']['venues']
      else
        @error = body['meta']['errorDetail']
      end
    rescue
      Faraday::ConnectionFailed
      @error = 'There was a timeout. Please try again'
    end
    render 'search'
  end
end
