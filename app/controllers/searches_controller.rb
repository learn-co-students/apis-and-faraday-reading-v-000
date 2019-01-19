class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'CJ533OYTNV0XHAQO0PNQWGAYNI1NN5CT05JSVE1L4PZO2ES2'
      req.params['client_secret'] = 'EGSB2V5MQJB5MKYC5R0ADHM35OA125GPQ2DKCJQ1LDIRQRMU'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      # req.options.timeout = 0
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
