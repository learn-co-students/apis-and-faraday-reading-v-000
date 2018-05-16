class SearchesController < ApplicationController
  def search
  end

  def foursquare
  #   @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
  #     req.params['client_id'] = 'IYKA2IC2AHC2ZQSP11BFFGDFGCWHV5RG5ZJGBCIPQZQMWU4T'
  #     req.params['client_secret'] = 'YXZAQHQE4Y0ZCCYXM1TUAWKDW1Q5HLYWLA1XPC4ZGTDSNAVO'
  #     req.params['v'] = '20160201'
  #     req.params['near'] = params[:zipcode]
  #     req.params['query'] = 'coffee shop'
  #   end
  #   body = JSON.parse(@resp.body)
  #   if @resp.success?
  #     @venues = body["response"]["venues"]
  #   else
  #     @error = body["meta"]["errorDetail"]
  #   end
  #   render 'search'
  # end
  begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'IYKA2IC2AHC2ZQSP11BFFGDFGCWHV5RG5ZJGBCIPQZQMWU4T'
        req.params['client_secret'] = 'YXZAQHQE4Y0ZCCYXM1TUAWKDW1Q5HLYWLA1XPC4ZGTDSNAVO'
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
