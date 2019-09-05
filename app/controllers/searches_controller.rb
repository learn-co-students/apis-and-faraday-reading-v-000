class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
        @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'NO3JFTKR23IPKTB0JGB33WMWTJEV0VR1ITJGSSDVWYUSZL1W'
        req.params['client_secret'] = 'LBJMCABWG4UQFZJGL2KS5YZGNJQZGXIN5ECKRAIO2CUQ1BIP'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
         req.options.timeout = 0
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
