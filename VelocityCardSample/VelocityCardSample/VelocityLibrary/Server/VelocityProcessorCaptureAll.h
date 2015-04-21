//
//  VelocityProcessorCaptureAll.h
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 30/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@protocol VelocityProcessorCaptureAllDelegate<NSObject>
@required
-(void)VelocityProcessorCaptureAllServerRequestFinishedWithSuccess:(id)successResponse;
-(void)VelocityProcessorCaptureAllServerRequestFailedWithErrorMessage:(id)failResponse;
@end
@interface VelocityProcessorCaptureAll : NSObject<NSURLSessionTaskDelegate,NSURLSessionDataDelegate>
@property (nonatomic, strong) id <VelocityProcessorCaptureAllDelegate> delegate;
-(void)CaptureAllWithsAppprofileid:(NSString *)appProfileID andMerchentID:(NSString *)merchantID andWorkFlowID:(NSString *)workDFlowID andSessionToken:(NSString *)sessionToken andIsTestAccount:(BOOL)isTestAccount;

@end
