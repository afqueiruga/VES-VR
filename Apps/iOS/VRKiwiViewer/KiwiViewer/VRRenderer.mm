#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support. Compile with -fobjc-arc"
#endif

#define NUM_CUBE_VERTICES 108
#define NUM_CUBE_COLORS 144

#import "VRRenderer.h"

#import <AudioToolbox/AudioToolbox.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>

#import "GVRHeadTransform.h"

#include "vesKiwiViewerApp.h"

@implementation VRRenderer {
    int _sound_object_id;
    
    vesKiwiViewerApp::Ptr mKiwiApp;
    
}

- (void) initializeKiwiApp
{
    
    std::string dataset = [[[NSBundle mainBundle] pathForResource:@"teapot" ofType:@"vtp"] UTF8String];
    
    self->mKiwiApp = vesKiwiViewerApp::Ptr(new vesKiwiViewerApp);
    //self->mKiwiApp->initGL();
    [self resizeView];
    self->mKiwiApp->loadDataset(dataset);
    self->mKiwiApp->resetView();
    //self->mKiwiApp->setBackgroundColor(1.0,0.0,0.0);
}
-(void) resizeView
{
    //double scale = self.view.contentScaleFactor;
    //self->mKiwiApp->resizeView(self.view.bounds.size.width*scale, self.view.bounds.size.height*scale);
    //self->mKiwiApp->resizeView(100, 100);
}

#pragma mark - GVRCardboardViewDelegate overrides

- (void)cardboardView:(GVRCardboardView *)cardboardView
     willStartDrawing:(GVRHeadTransform *)headTransform {
    [self initializeKiwiApp];
}

- (void)cardboardView:(GVRCardboardView *)cardboardView
     prepareDrawFrame:(GVRHeadTransform *)headTransform {
    // Update audio listener's head rotation.
    const GLKQuaternion head_rotation =
    GLKQuaternionMakeWithMatrix4(GLKMatrix4Transpose([headTransform headPoseInStartSpace]));
    
    // Clear GL viewport.
    glClearColor(0.0f, 0.0f, 1.0f, 1.0f);
    glEnable(GL_DEPTH_TEST);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_SCISSOR_TEST);
}

- (void)cardboardView:(GVRCardboardView *)cardboardView
              drawEye:(GVREye)eye
    withHeadTransform:(GVRHeadTransform *)headTransform {
    CGRect viewport = [headTransform viewportForEye:eye];
    //self->mKiwiApp->resizeView(10, 10);
    glViewport(viewport.origin.x, viewport.origin.y, viewport.size.width, viewport.size.height);
    //self->mKiwiApp->resizeView(viewport.size.width, viewport.size.height);
    glScissor(viewport.origin.x, viewport.origin.y, viewport.size.width, viewport.size.height);
    
    // Get the head matrix.
    const GLKMatrix4 head_from_start_matrix = [headTransform headPoseInStartSpace];
    
    // Get this eye's matrices.
    GLKMatrix4 projection_matrix = [headTransform projectionMatrixForEye:eye near:0.1f far:100.0f];
    GLKMatrix4 eye_from_head_matrix = [headTransform eyeFromHeadMatrix:eye];
    
    // Compute the model view projection matrix.
    GLKMatrix4 model_view_projection_matrix = GLKMatrix4Multiply(
                                                                 projection_matrix, GLKMatrix4Multiply(eye_from_head_matrix, head_from_start_matrix));
    GLKMatrix4 model_view_matrix = GLKMatrix4Multiply(eye_from_head_matrix, head_from_start_matrix);
    // Render from this eye.
    [self renderWithModelViewProjectionMatrix:model_view_matrix.m withProjectionMatrix:projection_matrix.m];
}

- (void)renderWithModelViewProjectionMatrix:(const float *)model_view_matrix
                       withProjectionMatrix:(const float *)projection_matrix {
    self->mKiwiApp->render_models_only((float*)GLKMatrix4Identity.m,(float*)model_view_matrix, (float*)projection_matrix);
}

- (void)cardboardView:(GVRCardboardView *)cardboardView
         didFireEvent:(GVRUserEvent)event {
    switch (event) {
        case kGVRUserEventBackButton:
            NSLog(@"User pressed back button");
            break;
        case kGVRUserEventTilt:
            NSLog(@"User performed tilt action");
            break;
        case kGVRUserEventTrigger:
            NSLog(@"User performed trigger action");
            self->mKiwiApp->handleSingleTouchPanGesture(0.0,15.0);
            break;
    }
}

- (void)cardboardView:(GVRCardboardView *)cardboardView shouldPauseDrawing:(BOOL)pause {
    if ([self.delegate respondsToSelector:@selector(shouldPauseRenderLoop:)]) {
        [self.delegate shouldPauseRenderLoop:pause];
    }
}

@end
