class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'E1TLMG2L5KU40ABDMD4R4HAIDXAYK1WPXCHHVHBSV1ZHZXCM'
      req.params['client_secret'] = 'W3ZQEGMM1UF53K2UXBH0R3KVIS2GUCK3SDYWHVRG3EZQ1TMY'
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
