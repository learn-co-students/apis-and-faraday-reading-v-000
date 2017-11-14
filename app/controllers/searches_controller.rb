class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'FU20LEL3SXDNEFK1GIP3TQJOACLIU1XK4EHRYQE2J3GJ30XA'
        req.params['client_secret'] = 'EXEZW0ZOXWJ2A0JEJWRYYVQCDUMEPAAIIQYFBZ3PRNHBN4MX'
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
