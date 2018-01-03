class SearchesController < ApplicationController

  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'TMSG2DWAHJS0REYBH3O1YMGDYS5PZRFIIPMJJPIR5BNGUH52'
      req.params['client_secret'] = 'IC3JVCRCUJW5VCX10FDBLEZWTXC5SLOL5HSTQEEZL3I5P0KY'
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

    render 'search'
  end

end
