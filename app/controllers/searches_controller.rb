class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	begin
	  	resp = Faraday.get('https://api.foursquare.com/v2/venues/search') do |req|
	  		req.params['client_id'] = ENV['FOURSQUARE_ID']
	  		req.params['client_secret'] = ENV['FOURSQUARE_SECRET']
	  		req.params['v'] = '20160102'
	  		req.params['near'] = params[:zipcode]  		
	  		req.params['query'] = params[:food_type]  		
	  	end
	  	if resp.success?
	  		body = JSON.parse(resp.body)
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
