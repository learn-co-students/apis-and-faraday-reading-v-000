class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '252Z1TM1DCTPF13YY2C12BHAZDDS3ZV2XMLO2IFV5HAPABHW'
        req.params['client_secret'] = 'MWP3TR2J5IKK1NRLYBQLH3UVTDJ3OLAHGZY2PJXGGFFARQDT'
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
