class SearchesController < ApplicationController
  def search
  end

 def foursquare
  begin
      client_id = 'J5LRUUWGTIC0SBZKHQ1SM2ZYMC5EVZR3Y4QYAXVUZJZY5F3I'
      client_secret = 'MQRUHSTWYIOC5MQTREWQDWW1MQEZZMP2ELSITF5LFRBB2V3B'
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = client_id
          req.params['client_secret'] = client_secret
          req.params['v'] = '20160201'
          req.params['near'] = params[:zipcode]
          req.params['query'] = 'coffee shop'
          req.options.timeout = 10
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


