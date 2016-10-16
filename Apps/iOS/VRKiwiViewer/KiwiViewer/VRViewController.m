//
//  VRViewController.m
//  MyKiwiViewer
//
//  Created by Alejandro Francisco Queiruga on 10/4/16.
//  Copyright © 2016 Pat Marion. All rights reserved.
//

#import "VRViewController.h"

#import "VRRenderLoop.h"
#import "VRRenderer.h"

@interface VRViewController ()<VRRendererDelegate> {
    GVRCardboardView *_cardboardView;
    VRRenderer *_VRRenderer;
    VRRenderLoop *_renderLoop;
    vesKiwiViewerApp::Ptr mKiwiApp;
}
@end

@implementation VRViewController

- (void) setKiwiApp:(vesKiwiViewerApp::Ptr)appPtr {
    
    self->mKiwiApp = appPtr;
    [self->_VRRenderer setKiwiApp:self->mKiwiApp];

}


- (void)loadView {
    //EAGLContext *context;
    //context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    //GLKView *view = (GLKView *)self.view;
    //view.context = context;
    
    _VRRenderer = [[VRRenderer alloc] init];
    _VRRenderer.delegate = self;
    [self->_VRRenderer setKiwiApp:self->mKiwiApp];
    _VRRenderer.parentvc = self;
    _cardboardView = [[GVRCardboardView alloc] initWithFrame:CGRectZero];
    _cardboardView.delegate = _VRRenderer;
    _cardboardView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _cardboardView.vrModeEnabled = YES;
    
    // Use double-tap gesture to toggle between VR and magic window mode.
    UITapGestureRecognizer *doubleTapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTapView:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [_cardboardView addGestureRecognizer:doubleTapGesture];
    self.view = _cardboardView;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    _renderLoop = [[VRRenderLoop alloc] initWithRenderTarget:_cardboardView
                                                              selector:@selector(render)];
    //[EAGLContext setCurrentContext:_cardboardView.context];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // Invalidate the render loop so that it removes the strong reference to cardboardView.
    [_renderLoop invalidate];
    _renderLoop = nil;
}

#pragma mark - VRRendererDelegate

- (void)shouldPauseRenderLoop:(BOOL)pause {
    _renderLoop.paused = pause;
}

#pragma mark - Implementation

- (void)didDoubleTapView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

    _cardboardView.vrModeEnabled = !_cardboardView.vrModeEnabled;
}

@end
