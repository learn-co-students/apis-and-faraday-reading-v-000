class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "02ADPI3I4F14NVHUP5Q1POBJUM4IOC4D3RCZQ43SLNP30PN5"
        req.params['client_secret'] = "4NI5Y0WVXD5NW4FBHRQTMFODVZVCD3UEWP0QOFJO31GHZPFA"
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
      rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
      end
    render 'search'
  end

end
