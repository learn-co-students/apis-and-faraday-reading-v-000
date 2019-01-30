class SearchesController < ApplicationController
  def search
  end

  def foursquare
    client_id = 'FBHSB1QPNPIAYCKORRVDQOG5RYALCPAKLYHXMT0QAK5Q1XQ5'
    client_secret = 'SWUBJT0ZHXLFFI0KHNUUDGR34OTHVV42DU3APRDYGMGOQVIM'

    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = client_id
        req.params['client_secret'] = client_secret
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
