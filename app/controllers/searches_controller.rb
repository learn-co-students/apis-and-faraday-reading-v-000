class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'VMO5L1PKQCZ1OZPSA2VDU1CGVZQWG1TPQ3BATIXI3RC2Z2UR'
        req.params['client_secret'] = 'LEFTU0GVUC205DKOA4OGF1KJWAAH1MQ0NBQRSFBINFSOO4BS'
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
      @error = "There was a timeout.  Please try again."
    end
    render 'search'
  end
end
