class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = 'YXWAFCO52FZUEH3WVYNHGTKIKWHNXOPFUJM00W14UZOWRC1C'
        req.params['client_secret'] = 'H3VMJLXCNLXENLDE4OWI2DGDZYRHV3NFF2EHQZ3WT4AOUCYK'
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
