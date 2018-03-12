class SearchesController < ApplicationController
	
	def search
  end

	def foursquare
	  begin
		response = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
			req.params['client_id'] = ENV["FS_CLIENT_ID"]
			req.params['client_secret'] = ENV["FS_CLIENT_SECRET"]
			req.params['v'] = '20160201'
			req.params['near'] = params[:zipcode]
			req.params['query'] = params[:query]
			@req = req
		end
		body = JSON.parse(response.body) 
		if response.success?
			@venues = body["response"]["venues"]
		else
			@error = body["meta"]["errorDetail"]
		end
		
	rescue Faraday::TimeoutError
		@error = "There was a timeout. Please try again."
	end
	render 'search'
end


def venue_details
	id = params['format']
	url = 'https://api.foursquare.com/v2/venues/' + "#{id}"
	 begin
		response = Faraday.get url do |req|
 			req.params['client_id'] = ENV["FS_CLIENT_ID"]
			req.params['client_secret'] = ENV["FS_CLIENT_SECRET"]
			req.params['v'] = '20160201'
		end
		body = JSON.parse(response.body)
		if response.success?
			@venue_details = {
				address: body['response']['venue']['location']['formattedAddress'].join,
				categories: body['response']['venue']['categories'][0]['name']
			}
		else
			@error = body["meta"]["errorDetail"]
		end
		rescue Faraday::TimeoutError
			@error = "There was a timeout. Please try again."
		end
		render 'search'
	end

def venue_photos
	id = params['format']
	url = 'https://api.foursquare.com/v2/venues/' + "#{id}" + '/photos'
	begin
		response = Faraday.get url do |req|
			req.params['client_id'] = ENV["FS_CLIENT_ID"]
			req.params['client_secret'] = ENV["FS_CLIENT_SECRET"]
			req.params['v'] = '20160201'
		end

		if response.success?
			body = JSON.parse(response.body)
			@venue_photos = []
			body['response']['photos']['items'].each do |photo|
				assembled_photo = photo['prefix'] + '200x400' + photo['suffix'] 
				@venue_photos << assembled_photo
			end
		else
			@error = body["meta"]["errorDetail"]
		end
		rescue Faraday::TimeoutError
			@error = "There was a timeout. Please try again."
		end
		render 'search'
	end
end
