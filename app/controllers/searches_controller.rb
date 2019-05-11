class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = 'LV4SRTPBWB3FCFSHLA54CJKYLC243CYADSIKIKT3KCGW1CVK'
          req.params['client_secret'] = 'AZHNXQS5PXK5BSNUG45MKE0NGAXKVKNICD3TXNXQAYBE2W31'
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
