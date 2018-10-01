class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '2NGY0VHBIZK3YKIWUNJGSO1DGZKLKMPAXL5Y24XTKSKXWLRB'
        req.params['client_secret'] = 'B5FR4N3FGVGB3UJB0VUAAEW1YLDGXKIS3QIQPMN30KTRU0GM'
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
