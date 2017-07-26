class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	begin 
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req| 
  		req.params['client_id'] = 'S5KOPOTMD4F1RAP55HWTTQWCUD3CSBM4BIX5INVZO10DKT2S'
  		req.params['client_secret'] = 'AI1HELCP3S12EICAZ4I13X2AQDVK1EBUIDJDHL21F1RQA5MV'
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
 
    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    
    render 'search'
  end
end                                                                                                          
