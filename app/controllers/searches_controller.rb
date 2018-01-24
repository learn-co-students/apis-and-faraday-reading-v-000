class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'TUVGESHOGJESNNV00PB0ZX0IC5Y1XSAB4TQQ3YE3H32DSPGT'
        req.params['client_secret'] = '5C2JWNJFXFIRR41MTVEZQV33FA02ZN25PHLPKD1JUJRC3EUN'
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

      rescue Faraday::TimeoutError
        @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
