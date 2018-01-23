class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'N1WA1KZL2EDDKSMVGSPPI5F5H21DJBPBKUKPOFYWMK3BKJQR'
      req.params['client_secret'] = '00QJAMOOEELIYWJHQWD2J5ARGMLELVTUGYVDC4RBAYOGRLJB'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["venues"]
    end

  rescue Faraday::ConnectionFailed
    @error =  "There was a timeout. Please try again."
  end

    render 'search'
  end

end
