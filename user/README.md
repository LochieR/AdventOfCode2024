# User data

So the inputs can be fetched from Advent of Code, your session cookie must be added to a file in this directory called session.cookie.

To get your session cookie, head to https://adventofcode.com and log in. Then (on Chromium based browsers) open the inspect panel (`Ctrl+Shift+I`) and head to the `Application` tab at the top.

On the left side of the panel, under storage, there is a cookies drop down.

![cookies drop down image](res/Screenshot%202024-12-01%20142357.png)

Open the drop down, and click on the Advent of Code option. Then, on the right of the panel, click on the session cookie, and copy the cookie value from the bottom of the panel. Paste this value into a file called `session.cookie` in this directory.
