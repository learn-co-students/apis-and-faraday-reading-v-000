class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	begin
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'GXLCGDPSHXECUL5G20J4DHS3RCNH1B12XV12TWXFTWFF2SFG'
      req.params['client_secret'] = 'CMQYNZ0JTU35E4ZW5ZZBE5DM40DWC2QHG4YOTVCG2HG3OCWX'
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
