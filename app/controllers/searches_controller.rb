class SearchesController < ApplicationController
  def search
  end

  def foursquare
  	@resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '12MLWJJIJQKE32YH0MQHSG4FXWDG30VK3P1HX5QXHQYGDSOP'
      req.params['client_secret'] = 'P4S3HE5BZXWIVKJUFCHNMY1KYJN1DNILWYY5YO3DUUIIEMXR'
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
