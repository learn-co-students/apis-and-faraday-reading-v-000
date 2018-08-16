class SearchesController < ApplicationController
  def search
  end

  # Use Faraday to query Foursquare API
  def foursquare
    begin
      @resp = Faraday.get "https://api.foursquare.com/v2/venues/search" do |req|
        req.params["client_id"] = 'Z2OMWZKVLCRFR1VMUXWXJXC4AWYDAIWAXS5DSRGVJAFZOQUB'
        req.params["client_secret"] = 'FTKAQF2JODQRWCK5UFF3KP450UZI5J254U1PJQNWWN1U4UYV'
        req.params["v"] = "20160201"
        req.params["near"] = params[:zipcode]
        req.params["query"] = "coffee shop"
        # req.options.timeout = 0  #set timeout value
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

    # display timeout error msg
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render "search"
  end
end
