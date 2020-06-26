class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'DBA4FGMPBB3U01LUE3WNKRYT0ECAR053ELDQKYT1DL30D5RA'
        req.params['client_secret'] = 'LQPVNTOVMPGAQNMGOWBU5LVZNY51A1RCFJ4IO5PZOE2GWFH1'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.params['limit'] = 10
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
