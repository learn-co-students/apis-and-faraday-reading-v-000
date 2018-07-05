class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'QJFO3SGBKHF5KKMB2OSGVGXTS0AHFXDLO3GI0YHLTVSXVNXB'
      req.params['client_secret'] = 'SWIYGPF5K4YXDJTYKIMCYH3LCBIBKX0AJODSUZ02LGW3FOIE'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body['response']['venues']
    else 
      @error = body['meta']['errorDetail']
    end

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end
    render 'search'
  end

end
