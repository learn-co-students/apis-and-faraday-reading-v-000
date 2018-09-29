class SearchesController < ApplicationController
  def search
  end

  def foursquare
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'FLVJIJWUBDT20RRTDKWPYMSKFKL20VYCI4EVYKY2BPKX5QTC'
        req.params['client_secret'] = 'IWNM2YHHC2FI0Q0N1WUPCPKOCUA1BWI3LCGXXSBKONCLBRA3'
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
