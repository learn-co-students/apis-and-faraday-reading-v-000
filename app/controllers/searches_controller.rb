class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
        @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
            req.params['client_id'] = '3CH10DEMD23DOULYSIJORZBKVHET2EJ4P1ZMSTE045WSOEUW'
            req.params['client_secret'] = 'KCCG0PZEZ10JSJ5YWD5YWL14EAH3FLXZY44MTSAM3HBVMF5P'
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
