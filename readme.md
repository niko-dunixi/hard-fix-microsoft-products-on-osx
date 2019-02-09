# Regularly restarts Microsoft products on OSX

## What and Why
I frequently run into problems with runing both Microsoft Outlook and Microsoft Teams on my Macbook for extended periods of time. This hasn't been just a one-off issue that occurred on one machine only one time. It's frequently an issue for me. Since I work remote at times, and even when in office it's the main way we communicate with each other, it is imperative that I remain reachable when I'm needed.

* Microsoft Outlook
  * After being open for long periods of time, it stops syncing. Manually navigating to the 'Send & Receive' button should work, but it doesn't. I've had a number of times where even _some_ messages get through, but not others and the issue is only remedied by restarting.
* Microsoft Teams
  * Not as egregious, but still bad. Teams will update itself, and when it starts back up it starts back up in a strange minified state that isn't actually started up. When it is in this state it isn't actually started up and logged in, so people will send you messages and you won't receive notifications.

In short, work critical applications are regularly unreliable. Since I have a vested interest in my career I've written this code to restart these apps regularly.

## How it works
1. First thing it does is utilize a one-line apple script to stop the app. This is the most graceful way to close a GUI application on OSX. `osascript -e "quit app \"${app_name}\"` tells macOS to close an app in essentially the same way you would if you'd chosen Quit from the drop down menu.
2. Second we wait for the app to close with pgrep. This lets us wait for the app to close (which might sometimes take longer or shorter, depending on latent variables).
  * If we end up waiting more than 5 seconds to exit, we force kill the application with `pkill -3 "${app_name}"`
3. Restart the same application. Giving it a clean state that is not un-responsive. You can start a GUI application from the command line with the `open -a "${app_name}"` command.