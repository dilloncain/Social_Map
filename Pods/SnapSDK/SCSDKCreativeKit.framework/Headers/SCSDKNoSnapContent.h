//
//  SCSDKNoSnapContent.h
//  SCSDKCreativeKit
//
//  Copyright © 2018 Snap, Inc. All rights reserved.
//

#import "SCSDKSnapContent.h"
#import "SCSDKCameraViewState.h"

#import <Foundation/Foundation.h>


@interface SCSDKNoSnapContent : NSObject<SCSDKSnapContent>

/**
 * @property cameraControl
 * @brief Camera controls when share content to Snapchat client.
 */
@property (nonatomic, strong) SCSDKCameraViewState * _Nullable cameraViewState;

@end
