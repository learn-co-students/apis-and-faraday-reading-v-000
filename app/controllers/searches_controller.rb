class SearchesController < ApplicationController
  def search
  end

  def foursquare
   begin
     @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'F35QNCY1F1GSYEJRQ4CIUM15ZLJMTR0J4BZBNLKRREN0FGRG'
        req.params['client_secret'] = 'CTRZZUJ55TW4EUFLO40FVDH5NYIRA4Z3ANIW5AWHIGQJZVEZ'
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
