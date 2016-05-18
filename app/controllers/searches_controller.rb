require 'pry'
class SearchesController < ApplicationController

  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'SXFAYD5ZIYP3DVAF1U2ABFDWLOBY0RAEWPCZFB5EPKJXSNYL'
      req.params['client_secret'] = 'AWPBVDR40IAPC4QBHDRYVJ0OO3FQ4YGJVGAXE3045ZV2SRSB'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      req.options.timeout = 0
    end

    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end

binding.pry


    render 'search'
  end

end
