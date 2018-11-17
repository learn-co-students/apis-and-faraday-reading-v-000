class SearchesController < ApplicationController
  def search
  end

  def foursquare
    #We use Faraday.get(url) to make a request to the API endpoint.
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |res|
      res.params['client_id'] = #
      res.params['client_secret'] = #
      res.params['v'] = '20160201'
      res.params['near'] = params[:zipcode]
      res.params['query'] = 'coffee shop'
    end
    #we parse the body of the response into a variable
    #called body_hash, which is now a Ruby Hash.
    #We can then access the venues under the response key.
    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    render 'search'
  end


end
