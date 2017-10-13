class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'RRLZKBIZCW53JGXRPM1BDEXGIE34RAF3PVREY4KOLENNJNM5'
      req.params['client_secret'] = 'O4LOI0HMWFLAZ5UJI3QVNPUXRUVTJPSADXXNP2N4BUC24LN3'
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
