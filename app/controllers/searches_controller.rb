class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = 'H3WR1GS5KDG0SPQADUE5LQOOQPLJVJPMY4N2SVDGJ0L4N2LR'
          req.params['client_secret'] = 'GEKEI3BJCJH0OEWF3PFI3FHKASEFFW2D4MOK0TWYYWS5V3GK'
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
