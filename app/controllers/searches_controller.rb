class SearchesController < ApplicationController
  def search
  end

  def foursquare
  begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id']= '50UIAORN4O4GAPSERRKMS0XWI1GK2AAHLK4BQTLNKFSRNMRH'
        req.params['client_secret'] = '4SY33GWKJBF1CMW5IM2OSTPTX5BCN5JSVDY1UYIQGU3ZCZTI'
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
