class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'GIAAYG2OUGCAZRW0B21BM21XRIJOCFKUC5R5XGCS1FE5V1CJ'
        req.params['client_secret'] = 'G141MLL00P5NCBT3LZLWO5ZSVGI14MLINPDVFZTWDFHB4LEZ'
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

      rescue Faraday::TimeoutError
        @error = "There was a timeout. Please try again."
      end

      render 'search'
  end
end
