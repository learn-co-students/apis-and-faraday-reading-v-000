class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '3RYDJQIS1SXQCDKVTDSMMY00JVPIR3UFTXUE0QQ4S4DY243X'
      req.params['client_secret'] = 'L43TC1SAFICZONB0XG11DRHELWCB5WILFSKDVUS4NMGVVT3Z'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash["response"]["venues"]
    else
      @error = body_hash['meta']['errorDetail']
    end
    render 'search'
  end
end
