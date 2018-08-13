class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'HY5QZBFD5GEMTEL2N3CCRMQRF0VYHOQ5QKW5ZRWGQ2MTCXXC'
        req.params['client_secret'] = 'Z31XAXTOLFWX5PSHUEBQIYNBLXACIMQM4IUG3D1KSWURXEXL'
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
