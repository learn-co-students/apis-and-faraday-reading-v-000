class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @response = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = ENV["client_id"]
        req.params['client_secret'] = ENV["client_secret"]
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        #req.options.timeout = 0
      end
      body_hash = JSON.parse(@response.body)
      if @response.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end
    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end

end
