Prosperent
==========

A rails wrapper for prosperent API.

Getting Started
---------------

Add this line to your
application's Gemfile:

```yaml
gem 'prosperent', git: 'https://github.com/whitesmith/prosperent.git'
```

And then add to your initializers folder your desired configuration:

```ruby
Prosperent.configure do |config|
  config.api_key = Figaro.env.prosperent_api_key
  config.method  = :post
  config.format  = :json
  config.zone	 = "uk"
end
```

Improving Prosperent
--------------------
This gem is still under development. It lacks of tests and more calls, so use it at your own risk.
Pull requests that add more features or that fix existing issues will be most welcome. This is my first gem, so just commenting on an issue and giving some insight into how something should work will be appreciated. No contribution is too small.


Credits
-------

![Whitesmith](http://i.imgur.com/Si2l3kd.png)

RubyCritic is maintained and funded by [Whitesmith][1]. Tweet your questions or suggestions to [@jbarbosa_][2] or [@Whitesmithco][3].

[1]: http://www.whitesmith.co/
[2]: https://twitter.com/jbarbosa_
[3]: https://twitter.com/Whitesmithco
