class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '2JIVBXJ0QPNTLER3VX2WWLOTEECNX4L4L0TPEHJG5O1ZTFQ3'
        req.params['client_secret'] = '50UU2TDWN03BTXTNPJBR52IU1FC2ZABE2BGSBJKCYTZKHPJH'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 60
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
