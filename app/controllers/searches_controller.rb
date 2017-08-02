class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	begin
	  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
	      req.params['client_id'] = 'EFHSTXWNBIJTDCOQOASCXUX0XRZODJ3FMP1CU02BWVQ2MVAY'
	      req.params['client_secret'] = 'JO1YNIIGFXK43XT1GQOTCJVJPORMR3UTSMKS3Y2V1FASW2FR'
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
