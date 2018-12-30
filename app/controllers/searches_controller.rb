class SearchesController < ApplicationController
  def search
  end

    def foursquare
      begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '3FLYMFS5BJD0LWT1YV101MJBJJEYTQL4QC5I5CBKUXG5HI4Z'
        req.params['client_secret'] = 'KDJDR4U3D2BR2SZ2FESYPLTKDIECRQBSHN5BSGV5O0DYPSC4'
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
