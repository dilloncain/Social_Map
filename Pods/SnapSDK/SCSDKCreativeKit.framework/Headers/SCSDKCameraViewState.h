//
//  SCSDKCameraControl.h
//  SCSDKCreativeKit
//
//  Copyright © 2018 Snap, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SCSDKCameraPosition) {
    SCSDKCameraPositionUnknown,
    SCSDKCameraPositionFront,
    SCSDKCameraPositionBack,
};

@interface SCSDKCameraViewState : NSObject

+ (NSString *)stringValueForSCSDKCameraPosition:(SCSDKCameraPosition)cameraPosition;

/**
 * @property cameraPosition
 * @brief Camera facing position setup in Snapchat client
 */
@property (nonatomic, assign) SCSDKCameraPosition cameraPosition;

@end
