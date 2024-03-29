//
//  VRViewController.h
//  MyKiwiViewer
//
//  Created by Alejandro Francisco Queiruga on 10/4/16.
//  Copyright © 2016 Pat Marion. All rights reserved.
//

#ifndef VRViewController_h
#define VRViewController_h

#import <UIKit/UIKit.h>

#include "vesKiwiViewerApp.h"

@interface VRViewController : UIViewController
- (void) setKiwiApp:(vesKiwiViewerApp::Ptr)appPtr;

@end

#endif /* VRViewController_h */
