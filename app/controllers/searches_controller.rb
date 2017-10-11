class SearchesController < ApplicationController
  def search
  end

  def foursquare

  begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'BEHWXFVXEWUYPSEIXY1EWKYRV3YLGQ2EI0ADBR50OJCQMC2T'
      req.params['client_secret'] = '1JGL3TVB3AIOAUEMSPV2PTMLV3H001HBN3CXOQJXDR5BGLIP'
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
