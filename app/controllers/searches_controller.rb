class SearchesController < ApplicationController
  def search
  end

  def foursquare
  end

  def foursquare
    begin
     @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
         req.params['client_id'] = "S1HDR2HRYBF01JM2AVC5RGUTENJTN0FBU3ZJCZLOOGMU5HJY"
         req.params['client_secret'] = "W4IJPVOF5ACTWIS0UELFP3XINIKLR15TW4ZRC3PKQTDKOFMZ"
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
