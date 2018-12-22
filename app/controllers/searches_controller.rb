class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "GR0HNN5CMIX5QX3GUJFLYGWNFZHNJFWAXIX5JZGRATKSYIGH"
      req.params['client_secret'] = "KMCKNWKZ4LJQNVJAK0EFJPIK1KSBSUMPDSYS2UIBUC3WSQA5"
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
