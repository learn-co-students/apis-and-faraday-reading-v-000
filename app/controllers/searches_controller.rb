class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'JGL0RFN2ZHKKONVSQUVEMRUON1EYWWMJ0LMRMCEIMIN1KW3A'
      req.params['client_secret'] = 'WO2TTZCSKEFLUQRVMYVPUTGUAQS3HFON5SYBJFROU15ULD5T'
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

    render 'search'
  end

end
