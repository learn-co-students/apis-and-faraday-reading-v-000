class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] =  'TFOJGRHG1NVTN0HRMM4LOL10NH1POOVIMPHEHO24PUEDSBF4'
      req.params['client_secret'] = 'AV5O1NL5YJ35CVORIUYW2TT3HKVP5TF0B4FWACEDFCEV54HN'
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

    rescue Faraday::TimeoutError
      @error = "There was a a timeout. Please try again"
    end
    render 'search'
  end
end
