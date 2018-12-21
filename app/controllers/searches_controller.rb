class SearchesController < ApplicationController
  def search
  end

  def foursquare
    # request to the API endpoint
    # returned object will represent a response capture in @resp
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
         req.params['client_id'] = "WFZZ2ZFBCSUDDBJKMVZSJOABLBER2E0SIUSKLG2SSZRWPGUN"
         req.params['client_secret'] = "I5OGDPDGRYCCRTHN4CCG5B3ZNUVTPQMKH0AKEJUYJMXOMDKR"
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
