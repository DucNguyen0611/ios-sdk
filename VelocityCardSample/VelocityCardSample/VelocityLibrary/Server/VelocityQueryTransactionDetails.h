//
//  VelocityQueryTransactionDetails.h
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 19/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol VelocityProcessorQueryTransactionDetailDelegate<NSObject>
@required
-(void)VelocityProcessorQueryTransactionDetailServerRequestFinishedWithSuccess:(id)successResponse;
-(void)VelocityProcessorQueryTransactionDetailServerRequestFailedWithErrorMessage:(id)failResponse;
@end
@interface VelocityQueryTransactionDetails : NSObject<NSURLSessionTaskDelegate,NSURLSessionDataDelegate>
@property (nonatomic, strong) id <VelocityProcessorQueryTransactionDetailDelegate> delegate;
-(void)queryTransactionDetailsAppprofileid:(NSString *)appProfileID andMerchentID:(NSString *)merchantID andWorkFlowID:(NSString *)workDFlowID andSessionToken:(NSString *)sessionToken andIsTestAccount:(BOOL)isTestAccount;
@end
