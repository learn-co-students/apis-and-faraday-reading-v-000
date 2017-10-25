class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = '3EKWHBQNCRFAW3QIIIR43CQ5M3HS3X4VLUWFTUSOKRYVMRO4'
          req.params['client_secret'] = 'DYIWTIMFBR1KS01Y4WXFPDLNUI1I3TYCNK2EV0DVTAQZO5IZ'
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
