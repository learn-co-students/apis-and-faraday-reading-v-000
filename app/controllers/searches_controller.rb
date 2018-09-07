class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'D00PBFK3TO1VPIBPC2XDIYLUWBPQM2YQJL3EA32JIJLFLN15'
        req.params['client_secret'] = 'FVGL1HGZ5UDXYUR4X0RVJP4QDBAKMEJMFR5OU5WVYMIU4WGC'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"][errorDetail]
      end
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
