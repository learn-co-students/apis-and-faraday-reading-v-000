class SearchesController < ApplicationController

  def foursquare
    begin
      @response = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = ENV["CLIENT_ID"]
        req.params['client_secret'] = ENV["CLIENT_SECRET"]
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        #req.options.timeout = 0
      end

      body = JSON.parse(@response.body)
      if @response.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
