+ The result of the last flip is stored in the properties `flipResult` and `flippedCards` in `CardMatchingGame`. The `CardGameViewController` will set the result based on these. This means that the `CardMatchingGame` exposes the state of the game (i.e. what happened in the last flip), hence other delegated can do something with this information.

+ Valid shadings and colors are saved as `const` like this: `FOUNDATION_EXPORT NSString *const SCShadingSolid;`. This means that we can make comparisons with `==` in the `match` method in `SetCard.m`.

+ History slider has been removed on Set, because the gray color on old entries interferred with the Set symbols.