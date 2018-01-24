class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '30TK45WDPGRBG4QB1AE5EILGCTUMNM11TDWWWWENAOLGXH2J'
      req.params['client_secret'] = 'FHXBWZFEQ3EWZ5BSEAVRMISQYT3S1F5ZT4NNEK34XEDHLNNU'
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
