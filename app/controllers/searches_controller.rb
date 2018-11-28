class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
         req.params['client_id'] = '4MQQ4N4I4LSFWHA3KHVOIFULMGDTABASLWHUKF3CGDYEIERO'
         req.params['client_secret'] = 'YM3CJJ5FX43YZKL5CKOUKRTP5KSSCUH2R0M22Z3KZ3HBWVAM'
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