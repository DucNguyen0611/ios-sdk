//
//  VelocityProcessor AuthorizeTransaction.h
//  VelocityCardSample
//
//  Created by Chetu on 22/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol VelocityProcessorAuthTXDelegate<NSObject>
@required
-(void)VelocityProcessorAuthTXServerRequestFinishedWithSuccess:(id)successResponse;
-(void)VelocityProcessorAuthTXServerRequestFailedWithErrorMessage:(id)failResponse;
@end
@interface VelocityProcessorAuthorizeTransaction : NSObject<NSURLSessionTaskDelegate,NSURLSessionDataDelegate>
-(void)verifySessionTokenInXML:(NSString*)sessionToken forAppProfileId:(NSString *)appProfileId forMerchantProfileId:(NSString *)merchantProfileId forWorkflowId:(NSString *)workflowId andType:(BOOL )isTestAccount;
@property (nonatomic, strong) id <VelocityProcessorAuthTXDelegate> delegate;
@end
