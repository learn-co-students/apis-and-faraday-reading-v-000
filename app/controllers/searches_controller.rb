class SearchesController < ApplicationController

  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'CU1KS0GDQ2EBEOU1MJA5QFCNTWEQ4U1MYDNCFZSLI0M1G3UQ'
      req.params['client_secret'] = '5MIFW1JEWJIH5DSDV34UFYAVFQJD2SCS1MPD0JZ3ZN5OYUYG'
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
