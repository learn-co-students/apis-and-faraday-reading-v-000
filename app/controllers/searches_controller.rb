class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'LQ2DAMFOZMJPH41LJIUY05UWO3UM5LZJTYTEOF0M3VKAMSZ3'
      req.params['client_secret'] = 'WXW0YTJUVUHCX3BDWJCVKOPPXXNFEE0U2FZ51L3RDVVLZ52W'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      #req.options.timeout = 0
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'

  end
end
