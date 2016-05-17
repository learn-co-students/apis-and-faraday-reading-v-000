class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '0KM3OWDH14DXFOJP5L5CWJ1DIZUEGRYEDN0JUAWAOMKTNWVZ'
      req.params['client_secret'] = '14KKOQH1FUDJ1MASHOJXJHZC44TH0TRXP3VS4WDXOHQEPJRY'
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
