class SearchesController < ApplicationController
	
	def search
  end

	def foursquare
	
	  begin
		@resp1 = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
			req.params['client_id'] = ENV["FS_CLIENT_ID"]
			req.params['client_secret'] = ENV["FS_CLIENT_SECRET"]
			req.params['v'] = '20160201'
			req.params['near'] = params[:zipcode]
			req.params['query'] = params[:query]
			# req.params['venuePhotos'] = 1
			# req.params['radius'] = '500'
			# req.options.timeout = 10
		end
		
		body = JSON.parse(@resp1.body) 
# binding.pry
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


def venue_detail(id)
	 url = https://api.foursquare.com/v2/venues/"#{id}"
	 begin
		@resp2 = Faraday.get url do |req|
			req.params['client_id'] = ENV["FS_CLIENT_ID"]
			req.params['client_secret'] = ENV["FS_CLIENT_SECRET"]
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

	def photos(id)
	 url = https://api.foursquare.com/v2/venues/"#{id}"/photos
	 begin
		@resp2 = Faraday.get url do |req|
			req.params['client_id'] = ENV["FS_CLIENT_ID"]
			req.params['client_secret'] = ENV["FS_CLIENT_SECRET"]
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