## CircularArrowDemo

This is an demonstration of rendering a circular arrow in Objective-C, including animation of the arrow with a display link.

Note, I also used `IB_DESIGNABLE` view so that you can render (and customize the appearance) in Interface Builder storyboard. You don't have to do this, but it makes designing of user interfaces a little easier.

![example image](https://i.stack.imgur.com/VK6Yn.gif)

See https://stackoverflow.com/a/28202828/1271826. Unlike that example, here I'm using the path to update a shape layer, enjoying the efficiencies of `CAShapeLayer` as opposed to overriding `drawRect`, but also opening up the possibility of using the `CAShapeLayer` to update a mask instead of simply displaying the shape layer.

This was developed in Objective-C on Xcode 9.1 for iOS 11.1. But, the basic ideas are equally applicable for different versions of Objective-C and iOS versions.

## License

Copyright &copy; 2017 Robert Ryan. All rights reserved.

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

--

13 November 2017
