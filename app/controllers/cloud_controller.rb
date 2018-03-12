class CloudController < ApplicationController
	
	def search
  end

	def cloudinary
		url = 'https://' + "#{ENV["API_KEY"]}" + ':' + "#{ENV["API_SECRET"]}" + '@api.cloudinary.com/v1_1/smithwebtek/resources/image'
	  begin
			response = Faraday.get url do |req|
				# req.api_key: ENV["API_KEY"]
				# req.api_secret: ENV["API_SECRET"]
				@req = req
			end
			binding.pry
			body = JSON.parse(response.body) 


		if response.success?
			@images = body["response"]["images"]
		else
			@error = body["meta"]["errorDetail"]
		end
		
		rescue Faraday::TimeoutError
			@error = "There was a timeout. Please try again."
		end
		render 'search'
	end
end
