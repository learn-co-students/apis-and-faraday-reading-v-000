class SearchesController < ApplicationController
  def foursquare
    begin
     @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
         req.params['client_id'] = UVNYUIV0OWLK3KVTXO0FCEIBZQSRKOFIIVWX4Y414C2N4YEM
         req.params['client_secret'] = 1PF1CTXYCWJRF1XNKOA0M3PLKUNDLDJD2OW4OPRKC2VM42RV
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
