class SearchesController < ApplicationController
  #rescue Faraday::TimeoutError

  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = '0VZWO4WLU1ESEJNDJJ2CKUBAZJPXY0AHIN1NHK5YPUVB5ASZ'
          req.params['client_secret'] = 'LN2IEDZS0ZYJYKHPFKVTCWFUHKHJ134XXC0D2B5H22U0YGIV'
          req.params['v'] = '20160201'
          req.params['near'] = params[:zipcode]
          req.params['query'] = 'coffee shop'
          req.options.timeout = 20
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
