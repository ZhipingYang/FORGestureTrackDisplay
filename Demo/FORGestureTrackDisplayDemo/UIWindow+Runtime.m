//
//  UIWindow+Runtime.m
//  XYDebugView
//
//  Created by Daniel on 01/06/2017.
//  Copyright © 2017 XcodeYang. All rights reserved.
//

#import "UIWindow+Runtime.h"
#import "FORGestureTrack.h"
#import <objc/runtime.h>
#import "NSObject+Runtime.h"

@implementation UIWindow (Runtime)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethodWithOriginSel:@selector(becomeKeyWindow) swizzledSel:@selector(xy_becomeKeyWindow)];
        [self swizzleInstanceMethodWithOriginSel:@selector(resignKeyWindow) swizzledSel:@selector(xy_resignKeyWindow)];
    });
}

- (void)xy_becomeKeyWindow
{
    [self xy_becomeKeyWindow];
    [self startTracking];
}

- (void)xy_resignKeyWindow
{
    [self xy_resignKeyWindow];
    [self endTracking];
}

@end
