class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '2GKRYQKWWNHNETFVW03GCOWMEQASAVWREF4V41OBR1DEDGZI'
      req.params['client_secret'] = 'KZ4VJIY5II0EOXRK5WOMKE1ZOJHGLWX3G342ECZDIPIUHBSP'
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
    render 'search'

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end

end
