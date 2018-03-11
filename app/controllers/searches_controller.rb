class SearchesController < ApplicationController
	

	CLIENT_ID = 'BJ43KLAHMKUYVNKPJGYUOJSP1EBIKRIDUYTG10UPVTB1JCZC'
	CLIENT_SECRET = 'BGQB4MZWRAUYF5VY0V5AZVLDCVP1SIBXJNU1IXX3BZNFPEON'


  def search
  end

	def foursquare
		
# raise params.inspect

# https://api.foursquare.com/v2/venues/search?client_id=BJ43KLAHMKUYVNKPJGYUOJSP1EBIKRIDUYTG10UPVTB1JCZC&client_secret=BGQB4MZWRAUYF5VY0V5AZVLDCVP1SIBXJNU1IXX3BZNFPEON&v=20160201&near=03110&query=bagel&radius=900

	  begin
		@resp1 = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
			req.params['client_id'] = CLIENT_ID
			req.params['client_secret'] = CLIENT_SECRET
			req.params['v'] = '20160201'
			req.params['near'] = params[:zipcode]
			req.params['query'] = params[:query]
			# req.params['venuePhotos'] = 1
			# req.params['radius'] = params["radius"].to_i
			req.options.timeout = 0
		end
		
		body = JSON.parse(@resp1.body) 
binding.pry
		if @resp1.success?
			@venues = body["response"]["venues"]
		else
			@error = body["meta"]["errorDetail"]
		end
		
	rescue Faraday::TimeoutError
		@error = "There was a timeout. Please try again."
	end
	render 'search'
end


def photos(id)
	 url = https://api.foursquare.com/v2/venues/"#{id}"/photos
	 begin
		@resp2 = Faraday.get url do |req|
			req.params['client_id'] = CLIENT_ID
			req.params['client_secret'] = CLIENT_SECRET
			req.params['v'] = '20160201'

		end
		body = JSON.parse(@resp2.body) 
		if @resp2.success?
			@venue_photos = [] # body["response"]["venues"]
			binding.pry
		else
			@error = body["meta"]["errorDetail"]
		end
		rescue Faraday::TimeoutError
			@error = "There was a timeout. Please try again."
		end
		render 'search'
	end
end