class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'FLAVHJXLGCNF12BAVNDAWEB4R5NTKJ3NGPGNU4LUE1CCCNDB'
        req.params['client_secret'] = 'ZQWJY0QKALAFHJXEPALEHCMMDUUPT1XAR1HHCLZQCBI1R0B2'
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
