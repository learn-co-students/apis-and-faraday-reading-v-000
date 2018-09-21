class SearchesController < ApplicationController
  def search
  end

  def foursquare
    #make a request to the API endpoint
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        #we set all the required parameters in a hash object
        #my client id and secret from foursquare.com/developers/apps
        req.params['client_id'] = 'F0SGI1XUSGGQT0SQSA1IL11YWZDYVULBB5UWG10344QMLBKN'
        req.params['client_secret'] = 'F0ELWDIRJUJI4J3LBIQFAP4P320UBVV2HTD0EKETTL1BMBDQ'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        #to force a timeout error, set time to zero
        #req.options.timeout = 0
      end
      #render the search view (search.html.erb)
      #storing the interesting part of the response in variables to access later
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
