class SearchesController < ApplicationController
  def search
  end

	def foursquare
	begin
		@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
		  req.params['client_id'] = 'JHFF4ELIM2ROEAEC2TEDI4JJ02EREJN11NAHY4A40BXGDFIP'
		  req.params['client_secret'] = '03A14FXZZR30X3MAAKBD0LZS4A20JHNAVQIYQSJ5D2XRQCPM'
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

end
