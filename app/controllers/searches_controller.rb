class SearchesController < ApplicationController
  def search
  end

  def foursquare
    # making a request to an api with Faraday
    begin 
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'MDJPPYRRH25QI1UFGGLEQRMEAXUVFOQWZBANUMYPD44C1TCH'
      req.params['client_secret'] = 'C4YRI115INKF4HRO3ABG3CLI35UDASYRSOBCPNWI0V2D0OTC'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      req.options.timeout = 500
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