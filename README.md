Class Cluster Examples
======================

This project contains two different implementations of Objective-C class clusters.

InitializerLevelCluster
-----------------------

`NSNumber` is a class cluster with one public base class and many private
subclasses, one for each initializer.

A naive solution for this is to simply
have the init methods return the appropriate subclass.  This has a small cost
associated as each time you call `[NSNumber alloc]` you would create an object
and then destroy it because `initWithInt:` releases the new instance and returns
a new one.  A better approach is to create a singleton `NSNumber` instance and
return it every time you call `[NSNumber alloc]`.

Going a step further you can
return a distinct subclass private subclass on `[NSNumber alloc]` and have it
manage all your cluster initializers while `NSNumber` manages methods common to
all subclasses.  This approach can be seen in the runtime headers for
[NSNumber](https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/Foundation.framework/NSNumber.h)
and [NSPlaceholderNumber](https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/Foundation.framework/NSPlaceholderNumber.h).

`InitializerLevelCluster` demonstrates this approach by returning a singleton
`PlaceholderInitializerLevelCluster` on `alloc` and a child from there.

AllocLevelCluster
-----------------

Classes like `NSString` are also clusters but return different subclasses based
on how they're allocated (among other things).  `@"hello"`, `[[NSString alloc]
initWithFormat:@"Hello, %@", friend]` and `[[NSMutableString alloc]
initWithString:@"mutate me!"]` can all return distinct subclasses of `NSString`
if they so choose.

`AllocLevelCluster` demonstrates this by returning an instance of
`ConcreteAllocLevelCluster` on `[AllocLevelCluster alloc]` and
MutableAllocLevelCluster on `[MutableAllocLevelCluster alloc]`.

This is fine with ARC?
----------------------

Reference counting rules for alloc/init are pretty straight-forward.

Whatever leaves `alloc` needs to have a +1 reference count.  If you
call `[super alloc]` or any other classe's `alloc`, it sees the +1 from the
function call and doesn't do an extra retain.  If you return a singleton it
knows that it's a +0 and will do a retain to get it to +1.

Whatever enters `init` gets a -1 and whatever leaves `init` gets a +1, so if you
return something other than the original `self`, `self` gets released cancelling
the retain from the `alloc`.  Similarly, ARC will see that you `alloc/init`'d
what you're returning and not do an extra retain.
