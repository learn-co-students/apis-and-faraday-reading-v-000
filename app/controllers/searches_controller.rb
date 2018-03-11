class SearchesController < ApplicationController

  require 'pry'

  def search
  end

  def foursquare
    client_id = 'P1CVQ4ECIXRXIKWNOKRK254CVZQJCARUYOWVCEUXD0XT5AQC'
    client_secret = 'NGAUBKFVSBKHABN5ZVWH25HQYJAM4SQKPKIH02ON5PNDEGCW'
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = client_id
        req.params['client_secret'] = client_secret
        req.params['v'] = '20180311'
        req.params['m'] = 'foursquare'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 10
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
