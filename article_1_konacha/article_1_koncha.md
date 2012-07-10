# Testing Your JavaScript/CoffeeScript, Part 1 of 2: Setting Up a Test Framework in Ruby on Rails

## In The Beginning

In this day and age there should be no reason for a good developer not to be testing his/her own code. The old arguments of "it's too hard to setup" and "I don't know how to test my code" just don't cut it anymore. Testing tools have never been easier to setup, configure, and use. 

One community that has embraced testing, with a near religious zealot status, is my beloved Ruby/Ruby on Rails community. When Rails first came on my radar in late 2005 I was well and truly embedded in Java land. I wrote a lot of Java code. I like to think that I was pretty good at too. One thing I didn't write a lot of at the time was tests for my Java code. In my Java days my method of testing consisted a lot of refreshing the browser. 

One of the very first things that struck me as interesting about Ruby on Rails, apart from Ruby (which blew my mind), was that there was a test framework built right in! When I generated a model or a controller a corresponding test was generated for me. Not only did Rails make testing my code easier, it was subtly pressuring me to write tests. My eyes opened and saw the light. There was no going back. From that point on everything, and I mean everything, needed to be tested. Except for my JavaScript.

Wait, what? You heard me. I went for years without testing my JavaScript code, and chances are you have too.

## A Sad State of Affairs

Near the beginning of this year I gave a presentation at the [Boston Ruby Users Group](http://bostonrb.org) and I asked the crowd of one hundred people a few questions.

I first asked, "Who here writes Ruby?" The entire audience raised their hands. I then asked, "Who tests their Ruby?", again the entire audience raised their hands. Next I asked, "Who here writes JavaScript or CoffeeScript?". Once more the entire audience raised their hands. Finally I asked, "Who tests their JavaScript or CoffeeScript?". A hush fell over the crowd as a mere six hands were raised. 94% of the people in that room wrote, but didn't test, their JavaScript. That number both saddened me and did not surprise me.

The reason why I wasn't surprised by that low number of people testing their JavaScript was because up until about a year ago, I was one of those people. What were my arguments for not testing my JavaScript code? The same as everyone elses. "It's too hard to set up.", "I don't know how to test my code.", and the big one, "I don't do much with JavaScript anyway, why should I bother?"

If you are reading this article now, I know that you've probably said those same things to yourself at one point or another. You've rationalized the lack of testing your doing. Well, no more. The cycle is going to end. Right here, right now.

So what was it that caused me to kick myself into gear and start testing all of my JavaScript code? Well, two things actually. The first being [CoffeeScript](http://www.coffeescript.org). All of a sudden my code read more like Ruby and less like JavaScript. Things seemed to make more sense all of a sudden. My code was clearer and better defined.

The second thing that changed, was a direct result of my love of CoffeeScript; I started writing JavaScript heavy front-end applications. For years I stayed away from doing all but the most minor of AJAX queries. JavaScript didn't have a "structure", it was a "messy", and it was very hard to test. Between CoffeeScript and [Backbone.js](http://documentcloud.github.com/backbone/) my front-end code was easy to write, it was well structured, and it was fun! 

Once I realized that I was writing the majority of my applications in CoffeeScript, I told myself that I have to start testing this code like I do my back-end Ruby code. That led me on a hunt to find some great tools for the job. 

## Let The Games Begin

During that hunt I realized a few things. The first is that JavaScript/CoffeeScript testing tools are much better than I ever thought. There are some absolutely fantastic tools out there, a few of them even better than their Ruby counterparts. The second thing I found is that these tools are easy to set up, configure, and run.

One of the most prominent tools out there for testing JavaScript, and CoffeeScript, applications is [Jasmine](http://pivotal.github.com/jasmine/). Jasmine was modeled after the popular Ruby testing framework, [RSpec](https://github.com/rspec). This is a great tool, and I have used it successfully on a number of projects. I even wrote a chapter about it in my book, [Programming in CoffeeScript](http://books.markbates.com). It's easy to use and fairly easy to set up. However, when working with Rails applications, I find that it is fairly cumbersome to set up.

There were a few gems out there, most notably [Evergreen](https://github.com/jnicklas/evergreen), that tried to make it easier to setup Jasmine with your Rails application. The problem was that none of these gems were well written, and most of them are fairly out of date.

Evergreen, for example, doesn't play nicely with the asset pipeline. It doesn't let you pull in particular parts of the pipeline easy. Nor does it allow you to add your own "support" files just for testing. It also does not give you the ability to run an individual spec, which can be very useful when you're practicing Test Driven Development (TDD).

After plenty of experimentation, frustration, and sheer terror, I finally found a gem that made all of my JavaScript testing dreams come true. That gem is [Konacha](https://github.com/jfirebaugh/konacha).

## Enter Konacha

Before I get into the specifics of the Konacha gem, I want to first say that I am a committer to the project. It was not my project to start with, I just fell in love with it and wanted to help make it better. I find it's always best to get that sort of thing out in the open before we move on. Full transparency.

So what is the Konacha gem, and what can it do it for us? Konacha let's us quickly set up and configure the [Mocha](http://visionmedia.github.com/mocha/) testing framework and the [Chai](http://chaijs.com/) assertion library with Rails.

Konacha gives us full access to the asset pipeline, and will allow you to customize which files you want to pull into your tests from the asset pipeline. It also, very conveniently, adds the `spec/javascripts` path to list of paths that can be used by the asset pipeline, meaning that you can create "support" files and pull them in quite easily, much like you can do with RSpec. 

In this article I want to focus on getting Konacha installed, configured, and running. I won't be going into details about Mocha and Chai here. We will look at that in the next article.

## Installing Konacha

To get started we must first create a new Rails application to work on:

<pre>
> rails new omgjs
</pre>

That will create a new Rails application for us. Now, in the `Gemfile` of that application we need to add the following:

<pre>
# Gemfile
group :development, :test do
  gem 'konacha'
end
</pre>

With that in place we just need to run `bundle install` to install the Konacha gem and we should be good to go.

## Writing Our First Test

To test that this works the way we expect it to, let's write a simple class and a test for it. I'm going to be writing all of the examples in this article in CoffeeScript, because I definitely feel it is the best way to write JavaScript as of right now, but please know that everything I show here also applies to JavaScript, so whatever you chose, JavaScript or CoffeeScript, this article, and it's subsequent partner article, will apply to you.

In `app/assets/javascripts` create a new file called `greeter.js.coffee`. In that file let's create a class called `Greeter` that has a function, `sayHello`. The `sayHello` function will take a `name` argument and responds with a string that greets that name.

<pre>
# app/assets/javascripts/greeter.js.coffee
class @Greeter

  sayHello: (name) ->
    "Hello #{name}!"
</pre>

Now let's create a simple test to assert that the `sayHello` does what we expect it to do. By default, Konacha expects all tests to be in the `spec/javascripts` folder, this can be configured if you prefer a different location. I find the default location to work just fine for me. In the `spec/javascripts` directory, you'll probably need to create these folders, create a new file called, `greeter_spec.js.coffee`. Another default of Konacha is that tests must end with `_spec`. This follows the RSpec style of determining what is a test and what is not.

<pre>
# spec/javascripts/greeter_spec.js.coffee
#= require application

describe "Greeter", ->

  it "says hello", ->
    greeter = new Greeter()
    greeter.sayHello("Mark").should.eql("Hello Mark!")
</pre>

If you have seen, or written, RSpec tests before than this test should be fairly familiar to you. If not, the basic gist of what is happening is that we are requiring the `application.js` file from the asset pipeline, which by default will include our `greeter.js.coffee` file. It then sets up a test and asserts that the `sayHello` function behaves correctly.

## Running the Test Suite

With a test written all that is left to do is run it. That can be done in one of two ways. The first is in the browser. To do that we can start up the server that Konacha ships with.

<pre>
> rake konacha:serve
</pre>

That command will start a server on port `3500`. If you then navigate to the `http://localhost:3500` you should be greeted with a screen that should look something like this:

<img src="article_1_konacha/screenshot1.png">

Congratulations! You have written, and run, your very first JavaScript/CoffeeScript test. 

When we go to `http://localhost:3500` it will run the entire test suite we have written, in this case just the one test. However, should we want to run just this one file, we can do it by visiting `http://localhost:3500/greeter_spec`.

<img src="article_1_konacha/screenshot2.png">

While running the test suite is really fast, a lot of the time, it is really nice to be able to run the specs in the background, using a tool like [Guard](https://github.com/guard/guard/), or as part of your continuous integration server. To do this we can run the following Rake task:

<pre>
> rake konacha:run
</pre>

Now depending on how you have your system configured you should have noticed that when you ran that command the Firefox browser launched itself and then quickly disappeared. Why did it do that? Well, the answer is quite simple. Because we are testing JavaScript we need a JavaScript environment to execute the test suite in, so the Rake task launches a browser, runs the tests, exists the browser and prints something similar to the following back to your terminal window:

<pre>
.

Finished in 3.51 seconds
1 examples, 0 failures
</pre>

This is all well and good, but unfortunately having Firefox continuously keep popping up while you're trying to work isn't very nice. This also won't work on continuous integration servers that most likely don't have Firefox installed. So how do we solve this problem? We need to install a headless web browser.

## Going Headless

A headless web browser is a web browser that doesn't have a GUI, hence the name "headless". Think of this a somewhat "virtual" web browser. It can display web pages, and most importantly run our test suite, but it can do it all from the terminal window.

There are several great headless web browsers out there, but my personal favorite is [PhantomJS](http://phantomjs.org/). PhantomJS is very easily to install and works great. Both of which are two of the main bullet points I look for in a product such as this.

After you have PhantomJS installed, we need to install the Poltergeist gem. This gem contains the driver that will let us hook our tests into the headless browser that is PhantomJS.

<pre>
# Gemfile
group :development, :test do
  gem "konacha"
  gem "poltergeist"
end
</pre>

Don't forget to run `bundle install` after you have added the Poltergeist gem to the `Gemfile`.

All that is left to do is configure Konacha to use Poltergeist/PhantomJS. In the `config/initializers` directory create a new file called `konacha.rb`:

<pre>
# config/initializers/konacha.rb
if defined?(Konacha)
  require 'capybara/poltergeist'
  Konacha.configure do |config|
    config.driver = :poltergeist
  end
end
</pre>

In this file we are requiring the driver that Poltergeist gives us, `require 'capybara/poltergeist'` and telling Konacha to use that driver, `config.driver = :poltergeist`.

When we run `rake konacha:run` this time from the terminal window the test suite should run without Firefox rearing its ugly little head. Perfect!

Should we want to run individual specs from the command line Konacha let's us do that like such:

<pre>
> rake konacha:run SPEC=greeter_spec
</pre>

## Wrapping Up

Well, that concludes what we set out to do in this article; install, configure, and get up and running a test framework inside of Ruby on Rails. In the next article we will look at using Mocha and Chai, and a few other third party libraries to actually write our tests.

While that article will pick up where this one leaves off, it will be less Rails focused and more focused on the test suite itself, so even if you're not a Rails developer, I do hope you'll join me, as there is a lot to learn and almost all of it is applicable to any framework you are using.