set myAxis to choose from list {"side", "plane", "front", "top", "free"} with prompt "Please select which sound you like best" default items "side"

display dialog "Enter text" default answer myAxis
set myText to text returned of the result

--log "/Users/pim/.rvm/bin/rvm default do text2isometric " & myAxis & " '" & myText & "'"
do shell script "/Users/pim/.rvm/bin/rvm default do text2isometric " & myAxis & " '" & myText & "'"

tell application "Image Events"
	set img to open "/Users/pim/test2isometric/isometric.png"
	set my_dimensions to dimensions of img
	set my_x to item 1 of my_dimensions as integer
	set my_y to item 2 of my_dimensions as integer
end tell

tell application id "com.omnigroup.OmniGraffle6"
	tell canvas of front window
		make new shape at end of graphics with properties {fill:no fill, draws stroke:false, draws shadow:false, image scale:1, size:{my_x, my_y}, image sizing:stretched, image:"/Users/pim/isometric/isometric.png"}
	end tell
end tell
