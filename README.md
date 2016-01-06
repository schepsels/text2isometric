# Text2isometric

TODO: Write a gem description

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

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/text2isometric/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## AppleScript
```
display dialog "Enter text" default answer "some text"
set myText to text returned of the result
set myAxis to choose from list {"side", "plane", "front", "top"} with prompt "Please select which sound you like best" default items "side"

log "/Users/pim/.rvm/bin/rvm default do text2isometric " & myAxis & "'" & myText & "'"
--do shell script "/Users/pim/.rvm/bin/rvm default do text2isometric " & myAxis & "'" & myText & "'"

tell application "Image Events"
	set img to open "/Users/pim/test2isometric/isometric.png"
	set my_dimensions to dimensions of img
	
	set my_x to item 1 of my_dimensions as integer
	set my_y to item 2 of my_dimensions as integer
end tell

tell application id "com.omnigroup.OmniGraffle6"
	tell canvas of front window
		make new shape at end of graphics with properties {fill:no fill, draws stroke:false, draws shadow:false, image scale:1, size:{my_x, my_y}, image sizing:stretched, image:"/Users/pim/test2isometric/isometric.png"}
	end tell
end tell

```
