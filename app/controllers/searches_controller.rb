class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'IZIAO4SDL13QFDLCVN42XMOJWL4ZG1TWEIUON5YAA20OMSAB'
        req.params['client_secret'] = '4I5YIQVXKEDV3PDLWMCSL3D012TKAL33QR0NQ3LFOCSO1DXM'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 1
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body['meta']['errorDetail']
      end
    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
