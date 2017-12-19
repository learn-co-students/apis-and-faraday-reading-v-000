class SearchesController < ApplicationController
  def search
  end

  def foursquare
     @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
       req.params['client_id'] = 'AVIYW5F23KVHXUF1MWQS0LNLOIG15A1NISKJJ5SQ0RBE2IKG'
       req.params['client_secret'] = 'AYH4UUVEURCQUYYHM15IO55WLCVGP53BGCC4ZOGJZMQFL34S'
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
