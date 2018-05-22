class SearchesController < ApplicationController
  def search

  end

  def foursquare
  begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
		req.params['client_id'] = 'JXPAVG5TUJGTKCZAETZ5CK5SKLSFPF33IBSJUDFOKD0MBL3Z'
	    req.params['client_secret'] = 'K3B5R4PEIWG4MLRP5C3MIIR5VXH5YNYGNG2MGE50BH5FFOI4'
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


	  		