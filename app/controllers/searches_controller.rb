class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      response = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'EN5QIGEIJGYVD5UKXACQSUCCYCKYLKQSL3HJL2FOALTL1O23'
        req.params['client_secret'] = 'DJ5ULVUKS0HO3ATDY00KP1C10S3E4200KIBNS3Z0VLEBAJGK'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0
      end

      body = JSON.parse(response.body)
      if response.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
