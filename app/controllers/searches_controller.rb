class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '5A5LV1EQTYACJP4C3QHNT4WQ4NJ3RHXVOSPVEB3M3KMA4TAT'
      req.params['client_secret'] = 'HF44CBLQL0AY31E5DRRSAJHOICTIGZIL0DCBPJFHJH425YDI'
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
