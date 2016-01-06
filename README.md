# Text2isometric

Experimental gem and applescript for OmniGraffle to generate isometric
texts. Motivation was the realization that OmniGraffle is not able to
create 3d texts compatible with the nice AWS 3D stencils I wanted to
use.

It's a rather complex stack of technologies:

- 1 AppleScipt runs from OmniGraffle and will ask parameters
- 2 it than executes a ruby script that generates a html5 document with
  the 3d texts in the right direction.
- 3 than it run webkit2png and imagemagick to export the result
- 4 the image is placed in OmniGraffle

Like I said is experimental. If you can make it better please help...

## Images

For now I can create this:

![image](http://picdrop.t3lab.com/z3BupEf9oT.png)

I want to create this:

![image](http://picdrop.t3lab.com/nhM9DVEbWP.png)

We'll get there.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'text2isometric'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install text2isometric

## Usage

The text2isometric script has these options

```
Commands:
  text2isometric help [COMMAND]     # Describe available commands or one specific command
  text2isometric instgrafflescript  # install omnigraffle applescript
  text2isometric cube               # show cube with directions
  text2isometric free TEXT          # Generate text in text value
  text2isometric front TEXT         # Generate text in front
  text2isometric plane TEXT         # Generate text in plane
  text2isometric side TEXT          # Generate text in side
  text2isometric top TEXT           # Generate text in top
  text2isometric version            # Display version
```

In templates you will find an applescript called isometric-text.scpt.
You should tweak this to make it work on your computer.

Maybe someday this will be more usable. Or the people at omnigroup will
add this functionality natively. I hope the last.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/text2isometric/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


