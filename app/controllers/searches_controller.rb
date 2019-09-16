class SearchesController < ApplicationController
  def search
  end

  def foursquare
   @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
    req.params['2MCVWPU304MQ3J4QIXYOK1DQOHJN3DQKE0MYZSVIDQEGCX0L'] = client_id
    req.params['2CYL0IMARQF212XQOA5ZQKB0DMMISFCQLU4XOPFOAMXE4N0W'] = client_secret
    req.params['v'] = '20160201'
    req.params['near'] = params[:zipcode]
    req.params['query'] = 'coffee shop'
    req.options.timeout = 0
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
