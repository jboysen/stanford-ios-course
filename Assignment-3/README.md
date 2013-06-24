# Assignment 3

* Once again only required tasks have been done (except one small transition animation on the playing card game).
* `CardGameViewConroller` defines a set of abstract methods and properties, that need to be defined to make it work.
* Only games with custom Card views will now work, as the implementation only draws cards in collection views.
* `reloadData` is used to notify `CollectionView`s about changes.
* `CardMatchingGame` draws new cards via an API message, when the deck is empty the button will simply be disabled.
* Sizes in `SetCardView` are based on the ratio of the total size of the view.
* Cards are hidden only if the last match result was greater than 0. `CardMatchingGame` handles this through API message as well.
