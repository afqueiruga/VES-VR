//
//  VRRenderer.h
//  MyKiwiViewer
//
//  Created by Alejandro Francisco Queiruga on 10/4/16.
//  Copyright © 2016 Pat Marion. All rights reserved.
//

#ifndef VRRenderer_h
#define VRRenderer_h

#import "GVRCardboardView.h"
#include "vesKiwiViewerApp.h"
/** VR renderer delegate. */
@protocol VRRendererDelegate <NSObject>
@optional

/** Called to pause the render loop because a 2D UI is overlaid on top of the renderer. */
- (void)shouldPauseRenderLoop:(BOOL)pause;

@end

/** VR renderer. */
@interface VRRenderer : NSObject<GVRCardboardViewDelegate>

@property(nonatomic, weak) id<VRRendererDelegate> delegate;
@property(nonatomic, weak) UIViewController* parentvc;

- (void) setKiwiApp:(vesKiwiViewerApp::Ptr)appPtr;
@end


#endif /* VRRenderer_h */
