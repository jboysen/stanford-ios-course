# Assigment 4

* All tasks (including extras) have been done.
* A lot of the code is reuse from the Shutterbug demo.
* `RecentPhoto` is used to keep track of recently viewed photos - specifially I make use of the NSUserDefaults property list for the app.
* The robustness of the Recents tab is poor: if an image is deleted on Flickr, the image is still present in the Recents tab, as there is no check against Flickr when listing images.
* Initial zooming is done in `viewDidLayoutSubviews`, and only if the property `userHasZoomed` is false.
* Two segue identifiers are used to be able to differentiate between a tap from the Recents tab and the Photos for tag list. Only taps on the last view should add the photo to the recents list, or else the list will change when tapping on the Recents tab...