class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
     req.params['client_id'] = "V4EWLXQI2YQXQKAJ2LQP2I5ZUNBLAHM3U3Y5CPN5LXC0OGL1"
     req.params['client_secret'] = "GY2ULU1WADOB1KX2LN4GSR0TWD5CWPP5SCYPKYQCBAVUGK0C"
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
   render 'search'
  end
end
