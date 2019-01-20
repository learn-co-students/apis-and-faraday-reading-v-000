class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '3BFG3KKDMHRE0UH0XWHNNG2NHXGKOH0SMJ2T21Z5UPTR0AC3'
        req.params['client_secret'] = '4UYPM0ELIT1YIZW5FNQ35HEEAQZ4CHJCIYCM4KKISO2VMSDC'
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
