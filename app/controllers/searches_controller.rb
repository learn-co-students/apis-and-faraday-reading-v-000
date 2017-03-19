class SearchesController < ApplicationController
  def search
  end

  	def foursquare
	  	begin 
	  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
	        req.params['client_id'] = "1E0UNZXZT4B41I3GU0V3IPQYN1P5FTRGEYDRI1TMANUH51QP"
	        req.params['client_secret'] = "QS4DRT0RTTGEEAUCCXBJ5WT3SS3KEFUSXKQMLPUHBR4XAJ5H"
	        req.params['v'] = '20160201'
	        req.params['near'] = params[:zipcode]
	        req.params['query'] = 'coffee shop'
	        req.options.timeout = 0
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

		render :search
  	end


end
