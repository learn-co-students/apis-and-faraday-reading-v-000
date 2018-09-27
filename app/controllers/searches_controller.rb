class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'My Foursquare app client_id goes here'
        req.params['client_secret'] = 'My Foursquare app client_secret goes here'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode] # from form submission
        req.params['query'] = 'coffee shop'
      end
      body = JSON.parse(@resp.body) # body is a Ruby hash
      if @resp.success? # if @resp.status == 200 (success)
        @venues = body["response"]["venues"] # @venues stores array of venue hashes
      else # @resp.status == 400 (failure)
        @error = body["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
