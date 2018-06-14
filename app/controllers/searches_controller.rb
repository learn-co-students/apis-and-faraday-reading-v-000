class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
     @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
       req.params['client_id'] = 'KHCSIEKAIJ2ASUCSB2GRPJ1ZRRGZVEVFE3FKOIDRJRDONRP2'
       req.params['client_secret'] = '1QFTSHTVA4XCW23LGCJMQF4PCFFACQSGYI4DY0EWTBG1UUFT'
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
