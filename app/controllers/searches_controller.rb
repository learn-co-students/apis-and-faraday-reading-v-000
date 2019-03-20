class SearchesController < ApplicationController
  def search
  end

	def foursquare
		begin
			@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "1APQ5OFD5RRFF0RU3UY12JLUB1KZW4FDHRTZ1F55ULH3YBPX"
        req.params['client_secret'] = "EAC24N5ZVXHC3PJ011PAY4F3XNXQUX3HSJ0HEGNDWV432K2X"
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 2000
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
