class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'VH4OIPTAJIDGVBBFH4P0ZMNAO0DMP25XBGOO3OAVDE3QZOYV'
      req.params['client_secret'] = 'EUC0WTF2LFNFOMOUUXMKJRELFNRCER2G0PN5DQ5ZBIDURE3Z'
      req.params['v'] = '20150201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
  end
