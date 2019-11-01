class SearchesController < ApplicationController
  def search
  end

  def foursquare
   @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'LP4X4RZRVNPTOMQCPXX31FOO15KVNYS1GPR3IDZEA5DCAJC4'
      req.params['client_secret'] = "Y5AKWPD5VCQMUL24VHOKMWK4YSZUREDLNRGPAYOU3IMVYM1I"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      #req.options.timeout = 0
    end
    
    body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end
    
    #rescue Faraday::ConnectionFailed
      #@error = "There was a timeout. Please try again."
    
    render 'search'
   end

end
