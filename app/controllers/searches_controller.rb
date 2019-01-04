class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'UNM51KWKOGD4QTCXQYUJZGLI5N352400PQSUZ3JO1FWC2UYX'
        req.params['client_secret'] = 'G4CUVDCWYO5K0CSKJ0EP1JOJPTXGVLLIPMS0ZHHSJMQ1R2TZ'
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

    render :search
  end
end
