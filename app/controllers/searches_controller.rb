class SearchesController < ApplicationController
  def search
  end

	def foursquare
		@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
		  req.params['client_id'] = 'ZQLHHT13K5L0EBH3THDAUZYBKRHJZBFDPGD3D52KBECGJZV0'
		  req.params['client_secret'] = 'V5MYVECOMOGPM2LLSLDFRLFLJSZUOX0NNUL5UUGVG5HKMDK0'
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

		rescue Faraday::ConnectionFailed
      		@error = "There was a timeout. Please try again."
    	

		render 'search'
	end
end
