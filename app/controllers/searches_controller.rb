class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'Y43YF11KAFHUS4AII4RQPBURS1P2LXX3PUABYN4FSDYHCX34'
        req.params['client_secret'] = 'JUT3KKEDDYFBBYZR0D5TSSQBPWUZ4553VP2IYM1GQNVKI4KC'
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
      @error = "There was a time out. Please try again."
    end
    render 'search'
  end
end
