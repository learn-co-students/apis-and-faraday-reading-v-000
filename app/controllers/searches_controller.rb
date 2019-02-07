class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	begin
	  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
	      req.params['client_id'] = 'BMWQTZJLD2ACNFQHKPZ0X5JR53FQYWHLQHGUY4C0WGWPPLMC'
	      req.params['client_secret'] = '0XIRL2F41MRVGTG2S4OOGZJUDAAZ5IKQIHI25NJQNI4CHUTY'
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
