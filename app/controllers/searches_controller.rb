class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'QXMVOEQZG3CIMK41LE4TLR1YXS0DXWSTKBWA1ICYCEBTQFCQ'
        req.params['client_secret'] = 'SDOWMNZCSVPD0SP0VTB2O4UX0LBFJZ3NC5EFIGW4ZF5KROXB'
        req.params['v'] =  '20160201'
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
