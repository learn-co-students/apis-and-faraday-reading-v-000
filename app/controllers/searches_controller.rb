class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin

      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'YV30J24Z2K5FW0OC3EXHK5SQZWQBC0R4DIZ3VEWXXNKXKH2Q'
        req.params['client_secret'] = 'F4ZJELDXJPOQMV51RMIFDAAJMNGZVDZRXFF2PMGXYVZ3CJRK'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'

      end

      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash['response']['venues']
      else
        @error = body_hash["meta"]["errorDetail"]
      end

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end
end
