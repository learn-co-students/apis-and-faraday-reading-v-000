class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = '11XT4KZISEOIM1TOXNMU5K4UE1YHRDLRGFIRV2LQBSD23DDU'
      req.params['client_secret'] = 'X30JWSQIESMYBIRITQMLBALXRCFA2Q0SVGMZWKMMVJMMZAIA'
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
    @error = "There was a timeout. Please try again."
  end
  render 'search'
end
end
