class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin

      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'QLLQUKADNZY0UQKFW2K0AVG2D40LNT0AXUKAHMZUIQXREGEE'
        req.params['client_secret'] = '1PX45AANYYCQMQF20S24VT0LJ5CCPABJITJWAUBEY1PINBZ2'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 100
      end

      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      else
        @error = body_hash["meta"]["errorDetail"]
      end

      rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
    end
    render 'search'
  end

end
