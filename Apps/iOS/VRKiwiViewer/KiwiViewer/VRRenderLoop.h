//
//  VRRenderLoop.h
//  MyKiwiViewer
//
//  Created by Alejandro Francisco Queiruga on 10/4/16.
//  Copyright © 2016 Pat Marion. All rights reserved.
//

#ifndef VRRenderLoop_h
#define VRRenderLoop_h

#import <UIKit/UIKit.h>

@interface VRRenderLoop : NSObject

/**
 * Initializes the render loop with target and selector. The underlying |CADisplayLink| instance
 * holds a strong reference to the target until the |invalidate| method is called.
 */
- (instancetype)initWithRenderTarget:(id)target selector:(SEL)selector;

/**
 * Invalidates this instance and the underlying |CADisplayLink| instance releases its strong
 * reference to the render target.
 */
- (void)invalidate;

/** Sets or returns the paused state of the underlying |CADisplayLink| reference. */
@property(nonatomic) BOOL paused;

@end


#endif /* VRRenderLoop_h */
