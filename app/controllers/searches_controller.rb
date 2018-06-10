class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '3YNEVZ0NPAKFKZR3F5IJOAPMUUYTTKO0D4AU3PMVDO4WV1VF'
        req.params['client_secret'] = 'YGHEVIBRTV31ZBQWDLPAUMWS1MAE1UR3OJLF5YHYMYVJSWV0'
        req.params['v'] = '20180610'
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
