class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
     req.params['client_id'] = WJADC2YGU2CJ4WHT2VFOCBXTF4C3HLHRH5D0DGBES5GYDAYQ
     req.params['client_secret'] = XQ4NXKOMMEGJSLMCZ1JOSYAZK3HTSKCEB0PXPB2U5P35CJSC
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
end
