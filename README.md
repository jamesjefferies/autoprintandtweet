autoprintandtweet
=================

Simple receive and post adapter for Go Free Range printers

As part of the [Happenstance Project](http://happenstanceproject.com) we set up two printers from [Go Free Range](http://printer.gofreerange.com) so that they could receive text messages from [Twilio](http://twilio.com) and print them via the Go Free Range back end server.

This little ruby script is set up to be used with Sinatra and the twitter gem to receive post messages from Twilio, then pass them on to Go Free Range & Twitter.

Here is the [story of our printers](http://jamesjefferies.com/2012/08/30/the-story-of-cathy-and-heathcliff/).