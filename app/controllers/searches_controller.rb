class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
       req.params['client_id'] = 'TNIFVLDPT1KRAODJY31MCBCOO1RUBMJOPW1QS2AHZJF2NECZ'
       req.params['client_secret'] = 'TSSU55XB1CO01GWIN5ANCZEL5PHY0D0BJK5UUVB0PWN42XEW'
       req.params['v'] = '20160201'
       req.params['near'] = params[:zipcode]
       req.params['query'] = 'coffee shop'
       req.options.timeout = 100000
     end

  body = JSON.parse(@resp.body)
  if @resp.success?
    @venues = body["response"]["venues"]
  else
    @error = body["meta"]["errorDetail"]
  end
     render 'search'

   rescue Faraday::TimeoutError
    @error = "There was a timeout. Please try again."
  end
end
 end
