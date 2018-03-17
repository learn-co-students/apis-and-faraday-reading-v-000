class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'TQHS1YSNX40PFHDOWNCHVRQ21VNFTNLTZO3RXJPPG0VIKKGV'
      req.params['client_secret'] = 'DXSFXJGHA3XNAW103WA4UNNDI4SLVRP445ARDBT4QSZDFXT1'

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
