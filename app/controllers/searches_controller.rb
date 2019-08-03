class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
  		req.params['client_id'] = 'KZIFVHL4T3P02F1CEZ0S3X5ALCF5RFVTRCJ11UJYMRRPSTVL'
  		req.params['client_secret'] = 'QPE3MNL0G53LXVZJPUUWY1IU4RSY0BLT1GLOQFILRHK43WNT'
  		req.params['v'] = '20171205'
  		req.params['near'] = params[:zipcode]
  		req.params['query'] = 'coffee shop'
  	end
  	body_hash = JSON.parse(@resp.body)
  	if @resp.success?
			@venues = body_hash['response']['venues']
		else
			@error = body_hash['meta']['errorDetail']
		end

		 rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    
		render 'search'
	end
end
