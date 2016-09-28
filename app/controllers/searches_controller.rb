class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'H5XKIK20YODIAA1HAW51ZKEHXWQYNRW501EFKS1J3RBZ5IQH'
        req.params['client_secret'] = 'DRBIV5CXORS0KGNZVNLP5P54ABDLERAU3PZ4ANV1WAZS4CYC'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end

      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body['response']['venues']
      else
        @error = body["meta"]["errorDetail"]
      end
    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
