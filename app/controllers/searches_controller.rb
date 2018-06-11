class SearchesController < ApplicationController
  def search
  end

  def foursquare

    begin
      @resp = Faraday.get('https://api.foursquare.com/v2/venues/search') do |req|
        req.params[:client_id] = 'URH2NGCW33AK3SKUFL5NU5H4YGZ1ZGFBCRBRVTYOXTEW2F1C'
        req.params[:client_secret] = 'CXEQUEFDEJI3GBSBLA5OYRDSC3U0SQIUMQY3M1ECA0QUTT0K'
        req.params[:v] = '20180611'
        req.params[:near] = params[:zipcode]
        req.params[:query] = 'coffee'
        req.params[:radius] = '10000'
      end

      resp_hash = JSON.parse(@resp.body)

      if @resp.success?
        @venues_array = resp_hash["response"]["venues"]
      else
        @error = resp_hash["meta"]["errorDetail"]
      end
    rescue Faraday::ConnectionFailed
      @error = 'Timeout!'
    end
    render :search
  end
end
