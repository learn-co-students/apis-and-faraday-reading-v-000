class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	begin
	  	 @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
	      req.params['client_id'] = 'WYCIZ5YQPMITMJJQFVXEJC1I2ACDCDGU1EOFQA3AEQDTIXJW'
	      req.params['client_secret'] = 'LI3E5KGN0FG5V5WTDCJ45ED1NVDCPYB0RVPBWICFEE11SMUO'
	      req.params['v'] = '20160201'
	      req.params['near'] = params[:zipcode]
	      req.params['query'] = 'coffee shop'
	    end

	    body_hash = JSON.parse(@resp.body)
	    if @resp.success?
	    	@venues = body_hash["response"]["venues"]
	    else
	    	@error = body_hash["meta"]["errorDetail"]
	    end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end


end
