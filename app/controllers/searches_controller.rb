class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '1TYOT5NYCEZGXHMGJ0XDPMNOG0YH5QO5RUCDULSNDFFD1WPZ'
        req.params['client_secret']= 'AD3MFKLLK25RJRXHYPG0DO4YSWTAAQ4MWK1DV5XJR1STCEOS'
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
      @error = "There was a timeout.Please try again."
    end
    render 'search'
  end
end
