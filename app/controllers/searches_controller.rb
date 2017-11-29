class SearchesController < ApplicationController
  def search
  end

  def foursquare

begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'WOENLTMR3AUD0TMGTAU2IYHTXNDOAKI0QY0XHTDWWWYTV2L0'
        req.params['client_secret'] = 'BQSPRJ0DBNHIRFMCJ2MF4Q4BFEFDALWMSJTD05P12MTDGWTD'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        # req.options.timeout = 0
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
