class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'AYVJ10V33MXZLRQ5CFW25F2OGRQR0OP5N5ZAJNGIXNT3P0TU'
      req.params['client_secret'] = 'WPK2ITVT1WZB4WEVY5OQDG5JHDDVCNGRDS0MLACMELRO2K4P'
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

  rescue Faraday::TimoutError
    @error = "There was a timeout. Please try again."
  end
  render 'search'
end
