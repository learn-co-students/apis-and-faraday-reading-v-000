class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = "N4SA3OAUG5J2SJPQOKV5SEJFIKBGY1HR5DGSLRKAFQCHV4W4"
          req.params['client_secret'] = "LR4KIAHHAVFHSX0M3ZKJMR1EKPCBOXSO4YABGXK1V5WQ2CNP"
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
