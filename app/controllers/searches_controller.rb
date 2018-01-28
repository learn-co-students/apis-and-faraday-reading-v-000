class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	begin
	    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
	        req.params['client_id'] = 'B3HIIQQXNIUIE2ZR0SL5LTU3AVSVMKK0SASBOVPJQ3BPAAAJ'
	        req.params['client_secret'] = 'RV3HDGUPQ2AUJ50MNQIQ3GKQEMDMVK2OVJA5QSTQCE0RLAJ3'
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
