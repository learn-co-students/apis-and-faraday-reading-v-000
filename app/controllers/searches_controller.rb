class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['IPFY1IX3XRUZYWQ2RYOE1GC5H4PO2T2EH201UU00BAOJVV3Y'] = client_id
      req.params['PG2V3BKX3WF5AFFZIV22GR1M0UTT2S00CJ2EN0RG2MTKGD2V'] = client_secret
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

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end
end
