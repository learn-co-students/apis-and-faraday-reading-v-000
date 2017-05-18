class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'H4XGHAN2ZBP0HZDY5ZM45O1RR0YX21LLMJKUW2OBO4GLT15E'
      req.params['client_secret'] = 'BBJXMCBK1XIU201TWA0VDXXZUSWFM3SPJKOU4IYTIPBD5SXW'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash["response"]["venues"]
    else
      @error = body_hash["meta"]["errorDetail"]
    end

  rescue Faraday::TimeoutError
    @error = "There was a timeout. Please try again."
  end
    render 'search'
  end
end
