class SearchesController < ApplicationController
  def search
  end

  def foursquare
   begin

     @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
       req.params['client_id'] = 'CWZX1FKGI3QBZRLHQZUS55Y4E2GISDDJ3X5YCB542SIFX1XD'
       req.params['client_secret'] = '4APH0H3LHLCCOZPTETGQ3V1J54OFPNI1ZOLE110RZBSPALTD'
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

   rescue Faraday::TimeoutError
    @error = "There was a timeout. Please try again."
   end

   render 'search'
  end
end
