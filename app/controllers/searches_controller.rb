class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'IK3WDNLLE22ZXOVMQO5FXFUZJ003HMWOCENS2QOIT5EWXX33'
        req.params['client_secret'] = 'TGWX5GWD1TVKKHDDCS23TD1ACFRH34UOF34OODDO0KTW0W5T'
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
