class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "UOBVU1QF4XOXJBRHAHP1GW2SMBMNBTBXKNFNVDWMR3XDW2NI"
      req.params['client_secret'] = "1WLD32YH4M1VHOHJKWLFOEROIXLVQ3OVW1UHWTSYZKDGZ4HI"
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
