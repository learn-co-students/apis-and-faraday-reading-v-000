class SearchesController < ApplicationController
  def search
    Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'VUG2UXZIUN4JLWZC2P5J5DZ0RGCSG0MNHJBWRECEA5IES2EO'
      req.params['client_secret'] = 'EXUW3ZFNOIWR1VZAYB0KG5KL0TY31SUBKJNJAXPLJSDIGWE1'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    render 'search'
  end

  def foursquare
  begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'VUG2UXZIUN4JLWZC2P5J5DZ0RGCSG0MNHJBWRECEA5IES2EO'
      req.params['client_secret'] = 'EXUW3ZFNOIWR1VZAYB0KG5KL0TY31SUBKJNJAXPLJSDIGWE1'
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
