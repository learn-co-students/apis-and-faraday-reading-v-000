class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'VNNQR22SH3K3QF2UUGDSUQ5YLAI1QRRBRK5SQKU5BOFEKOTL'
      req.params['client_secret'] = 'MZUVFKUGJAWBFDWF242TOUSFOIB4OQAD4DLGNUFH33FOFGKJ'
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


    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
end
