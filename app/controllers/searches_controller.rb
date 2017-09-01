class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = "MWPUVZUAB1YHLFBT3GIW1Z5AN2B5XF1Y2323351PPEFDZZLZ"
        req.params['client_secret'] = "FEA0AUZHD2AMRCLAWI1M0XLN4GDKWAKTR3ZPHS12N40NW4OP"
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
