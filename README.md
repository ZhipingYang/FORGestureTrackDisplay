# FORGestureTrackDisplay
> FORGestureTrackDisplay is debug tool to displaying and tracking all kinds of gustures when user touch the screen.

![untitled](https://cloud.githubusercontent.com/assets/9360037/26645883/43bc2508-466c-11e7-99ec-baebdbf91257.gif)

## Usage

**first method**

> in AppDelegate

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    FORGestureTrack* track = [[FORGestureTrack alloc] initWithFrame:self.window.bounds];
    track.dotWidth = 40;
    [self.window addSubview:track];
    
    return YES;
}
```

**second method(recommend)**
> use runtime to hook window functions

```objective-c
@implementation NSObject (Runtime)

+ (void)swizzleInstanceMethodWithOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel {
    Method originAddObserverMethod = class_getInstanceMethod(self, oriSel);
    Method swizzledAddObserverMethod = class_getInstanceMethod(self, swiSel);
    
    [self swizzleMethodWithOriginSel:oriSel oriMethod:originAddObserverMethod swizzledSel:swiSel swizzledMethod:swizzledAddObserverMethod class:self];
}

+ (void)swizzleMethodWithOriginSel:(SEL)oriSel
                         oriMethod:(Method)oriMethod
                       swizzledSel:(SEL)swizzledSel
                    swizzledMethod:(Method)swizzledMethod
                             class:(Class)cls {
    BOOL didAddMethod = class_addMethod(cls, oriSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, swizzledMethod);
    }
}
@end
```

```objective-c
@implementation UIWindow (Runtime)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethodWithOriginSel:@selector(makeKeyAndVisible) swizzledSel:@selector(xy_makeKeyAndVisible)];
        [self swizzleInstanceMethodWithOriginSel:@selector(becomeKeyWindow) swizzledSel:@selector(xy_becomeKeyWindow)];
        [self swizzleInstanceMethodWithOriginSel:@selector(makeKeyWindow) swizzledSel:@selector(xy_makeKeyWindow)];
    });
}

- (void)xy_makeKeyAndVisible
{
    [self xy_makeKeyAndVisible];
    [self startTrack];
}

- (void)xy_becomeKeyWindow
{
    [self xy_becomeKeyWindow];
    [self startTrack];
}

- (void)xy_makeKeyWindow
{
    [self xy_makeKeyWindow];
    [self startTrack];
}

- (void)startTrack
{
    FORGestureTrack* track = [[FORGestureTrack alloc] initWithFrame:self.window.bounds];
    track.dotWidth = 40;
    track.layer.zPosition = CGFLOAT_MAX;
    [self addSubview:track];
}

@end
```