class SearchesController < ApplicationController
  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = "HE3HXPRCIGPTCKA5RFHPQNHHNXIPWIDXAVL40IW5IQ4YCNLW"
          req.params['client_secret'] = "HYCJFMMDFO20NIZPEKNL4DSV1NQOEBWJNDWJCRXDSQWGQ0TW"
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

      rescue Faraday::TimeoutError
        @error = "There was a timeout. Please try again."
      end
      render 'search'
    end

  def search
  end
end
