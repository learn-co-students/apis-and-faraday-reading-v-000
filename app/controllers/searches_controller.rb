class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @zipcode = params[:zipcode]
    @query = params[:query]

    begin
    	# GET request to API endpoint stored in an instance variable (accessible to the view)
    	@resp = Faraday.get('https://api.foursquare.com/v2/venues/search') do |req|
    		req.params['client_id'] = 'V1C42AGNBCLF2Z1AMS0P1UDE0KMHFSMG4GIVWYJ4OMS4GNYK'
    		req.params['client_secret'] = 'JL2CP3JOSVBVDYZE3C3J2EH5GQUSSSF343ONKCA3YG02XP4E'
        	req.params['v'] = '20160201'
        	req.params['near'] = @zipcode
        	req.params['query'] = @query
          req.options.timeout = 20
      end

      body = JSON.parse(@resp.body)
      # Faraday provides us with the .success? method, equivalent to checking if @resp.status == 200
      if @resp.success?
        @venues = body['response']['venues']
      else
        @error = body['meta']['errorDetail']
      end

    rescue Faraday::TimeoutError  
      @error = "There was a timeout. Please try again."
    end  
    
    render 'search'
  end
end
