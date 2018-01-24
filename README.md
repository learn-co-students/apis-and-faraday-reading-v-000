# APIs and Faraday

## Objectives

* Send `GET` requests to an API
* Translate api requests in Postman to api requests with Faraday
* Handle the response of a request

## Lesson

Let's use the [search](https://developer.foursquare.com/docs/venues/search) venue API to find a place to grab some coffee. Read through the documentation and use Postman to construct an API call to find coffee shops near you.

We want to pass parameters of `near` and `query`, along with our `client_secret`, `client_id`, and `v` parameters.

If we did it right, we should get a JSON response with an array of `venues`, each of which should conform to the [venue](https://developer.foursquare.com/docs/responses/venue) documentation.

Great! Now that we know how to query the API and get the results we want with Postman, how do we actually do this in code?

We're going to use [Faraday](https://github.com/lostisland/faraday) to access the Foursquare API from our Rails application. The basic app is set up, and you can code along as we add the feature to search for nearby coffee shops.

### Faraday

Faraday is an HTTP client library that abstracts and standardizes some lower-level HTTP functions and makes it easy to build requests and get responses from an API.

**Advanced:** In this lesson, and indeed in most cases, you'll use the built-in [Net::HTTP](http://ruby-doc.org/stdlib-2.3.0/libdoc/net/http/rdoc/Net/HTTP.html) library for HTTP functions. However, other libraries offer different advantages in categories like performance ([Patron](http://toland.github.io/patron/)) or multi-threading capability ([Typhoeus](https://github.com/typhoeus/typhoeus#readme)). Using a library like Faraday, which wraps and abstracts these lower-level libraries, allows you to maintain the same client code even if you change the underlying library later.

Add Faraday to the `Gemfile` and run `bundle install`:

```ruby
gem 'faraday'
```

Our `searches/search.html.erb` is already set up to post a `:zipcode` param to our `searches_controller`, so let's get in there and add the Foursquare API call with Faraday:

```ruby
# searches_controller.rb
  def foursquare
    Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    render 'search'
  end
```

Let's break this down. We use `Faraday.get(url)` to make a `request` to the API endpoint.

We know we need to set some `params` from our tests in Postman, and Faraday gives us an easy way to do this by passing a block to the `get` method and adding any parameters we need through the request object via a hash of `params`, very similar to the way we use params in Rails.

To keep it simple, we're just going to render the `search` template again with the result.

**Hint:** Remember to replace `client_id` and `client_secret` with your own ID and secret!

Let's run our Rails server and navigate to `/search`, and make a search!

Okay. Anticlimactic.

![jess welp](http://i.giphy.com/5q2TF9Kz4g6iI.gif)

### The Response Object

When we're working with Faraday, any time we make a *request* (such as `Faraday.get`), the returned object represents a *response*. The two most interesting parts of the response object are the `body`, which is where the server response, such as error messages or JSON results will be, and the `status`, which is the [HTTP code](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) the server returns from the request.

So let's make a change and get that response into a variable we can use:

```ruby
# searches_controller.rb
  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    render 'search'
  end
```

And in our template, let's take a look at that response `body`.

```erb
# views/searches/search.html.erb
<h1>Search for Coffee Shops Near Me</h1>
<%= form_tag '/search' do %>
  <%= label_tag :zipcode %>
  <%= text_field_tag :zipcode %>
  <%= submit_tag "Search!" %>
<% end %>
<div>
  <%= @resp.body if @resp %>
</div>
```

Let's run another search and see what we get.

Great! A lot of JSON! That's progress.

### Parsing The Response

We know we're getting back JSON, and we can see from the [documentation](https://developer.foursquare.com/docs/venues/search) that we can expect a response that includes an array of `venues`.

Looking at this response `body`, we see something like this:

`{"meta":{"code":200,"requestId":"56c0be42498e71008fcc8cc1"},"response":{"venues":[{"`

Okay, we see the `response` node, and we see it has a `venues` node, so that looks right. We also see a `meta` node that gives us some information that's, well, metadata on our request. We'll look at this more later.

So lets get those `venues` out of this JSON object and into a thing we can use in Ruby. We'll do that with the built-in `JSON.parse` method:

```ruby
# searches_controller.rb
# ...
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body_hash = JSON.parse(@resp.body)
    @venues = body_hash["response"]["venues"]
    render 'search'
```

So we parse the `body` of the response into a variable called `body_hash`, which is now a Ruby `Hash`. We can then access the `venues` under the `response` key.

In our `search.html.erb`, we can change `<%= @resp.body if @resp %>` to `<%= @venues %>` and re-run our search, and we can see the venues are now represented as an `Array` of `Hash`es that we can further parse.

We'll look at the documentation again and decide what fields we want, and come up with something like this:

```erb
# search.html.erb
# ...
<div>
  <% if @venues %>
    <ul>
    <% @venues.each do |venue| %>
      <li>
        <%= venue["name"] %><br>
        <%= venue["location"]["address"] %><br>
        Checkins: <%= venue["stats"]["checkinsCount"] %>
      </li>
    <% end %>
    </ul>
  <% end %>
</div>
```

We're now successfully using the Foursquare API to get coffee shops near the user!

![schmidt pizza](http://i.giphy.com/OJ8hVSLYbpQ08.gif)

### Handling Errors

Okay, let's search again, but this time don't enter a zipcode. Oof. That's ugly.

Now we could add some validation here and make sure that there's a zipcode, but we can't necessarily prevent every possible error with the API, because we aren't in control of the API.

So we need to understand how the API reports errors, and then handle them.

We said before that the two interesting pieces of the `response` object are the `body`, where all the data is, and the `status`. The status contains the HTTP code.

In most cases, a good API call will result in a status of `200`, which is the HTTP equivalent of the thumbs-up emoji.

If we make this request in Postman without a value in the `near` parameter, we'll get something like this:

```javascript
{
  "meta": {
    "code": 400,
    "errorType": "param_error",
    "errorDetail": "Must provide parameter ll",
    "requestId": "56c0cccd498e39675a357932"
  },
  "response": {}
}
```

And there will be a message that says `Status 400 bad request`. A status code of 400 is the HTTP equivalent of this:

![New Girl Facepalm](http://i.giphy.com/A1UF1VKksVOIo.gif)

So we have a `status` of 400, a `meta` node with some error information, and a `response` node that's empty, which makes sense, because we haven't made a good request.

Using this information, we can add some error handling to our application.

```ruby
# searches_controller.rb
  @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
    req.params['client_id'] = client_id
    req.params['client_secret'] = client_secret
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
  render 'search'
```

**Note:** We could have checked for `@resp.status == 200` as well, but Faraday provides us with a nice abstraction in `.success?`, which abstracts the low-level HTTP details into something readable and *intention-revealing*, which is a hallmark of good code.

And in our view, let's handle the possibilities:

```erb
# search.html.erb
# ...
<div>
  <% if @error %>
    <p><%= @error %></p>
  <% elsif @venues %>
    <ul>
    <% @venues.each do |venue| %>
      <li>
        <%= venue["name"] %><br>
        <%= venue["location"]["address"] %><br>
        Checkins: <%= venue["stats"]["checkinsCount"] %>
      </li>
    <% end %>
    </ul>
  <% end %>
</div>
```

Now we're using the API's error response to display what went wrong. We might decide that the default error message is not as friendly as we'd like, and choose to display a friendlier message to our users. That's one of many considerations when using an API - how much to alter the data you receive, but it's also one of the best things about using an API, because you get to make those choices.

**Top-tip:** Remember, not all APIs will structure their responses the same way. Always read the documentation!

### Handling Timeouts

One thing you must always be aware of when accessing resources across the internet on servers out of your control is the possibility of a request timeout.

Request timeouts can happen for any number of reasons, from network outages to code on the API server that just takes too long to execute.

To handle the timeout error, we just need to `rescue Faraday::TimeoutError` in our controller.

Luckily, we can also force a timeout by setting the request's `timeout` value. Normally you'd set this to a higher number than the default if the resource you were requesting was consistently too slow, however, if we set it to `0`, we can make it timeout to test our error handling:

```ruby
# searches_controller.rb
# ...
  begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = client_id
        req.params['client_secret'] = client_secret
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
        req.options.timeout = 0
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
```

If we run our search again, we should see our timeout error.

Now let's delete that `req.options.timeout = 0` line, because we would never want to actually force a timeout on every request.  Now we have a Foursquare API search that successfully finds coffee shops near the user, handles response errors, and guards against timeouts!

## Summary

We've seen how to use Faraday to consume the Foursquare API from within our Rails app, how to use the documentation to parse the response, and how to handle for common errors. Time to celebrate!

![winston happy](http://i.giphy.com/l2JIdnF6aJnAqzDgY.gif)

<p class='util--hide'>View <a href='https://learn.co/lessons/apis-and-faraday-reading' title='APIs and Faraday'>APIs and Faraday</a> on Learn.co and start learning to code for free.</p>
