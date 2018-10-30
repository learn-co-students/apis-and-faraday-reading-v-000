class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'ZYW5JTXJLMRD4B2XQZ1YSIFQJ2GBMAHQDQZB4ZZXVMLIL5ME'
        req.params['client_secret'] = 'MNCEEZLLOJ34CRS0ZWDJ4JIOPKMMDYGAYICRV0KMZQIN4LKP'
        req.params['v'] = '20160201'
        req.params['m'] = 'foursquare'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
      body_hash = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body_hash["response"]["venues"]
      # else
      #   @error = body["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
