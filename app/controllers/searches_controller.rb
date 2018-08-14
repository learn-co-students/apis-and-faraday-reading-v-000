class SearchesController < ApplicationController
  def search
  end

  def foursquare

    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '2XS3FSSAONBN4VC52SLBQ5GNXWVNQ1SFMQ0GO1AETOCYELBJ'
        req.params['client_secret'] = '4TB1YP3EV4S3NLSZ01HVGH5LDQ0FEWOEEOX11Y5QW4NJYOGQ'
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
