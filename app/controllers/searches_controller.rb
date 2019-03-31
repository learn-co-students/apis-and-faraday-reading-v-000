class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "U24ARJD4W2SDFRQZK0UWZZDMPWM31MQFCWQ313N34LNXYKXY"
      req.params['client_secret'] = "FITSESGM4JE2WKD15VJ5T4EGOMN1YX0NNTREH3QR45NTI1WE"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
 
    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
  end
end
