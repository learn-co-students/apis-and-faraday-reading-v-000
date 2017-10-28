class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "N2WYVJZQK2RXLPR53ZOF4YUUTXTE1SOTZWF5QC5E2WRMF4EO"
        req.params['client_secret'] = "Q10EOMXMG5Z2YJXC2ZPHHX2C0Q4DNY0VC5BHKKZV5HXFWOPJ"
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
