//
//  VelocityProcessorAdjust.h
//  VelocityCardSample
//
//  Created by Chetu on 11/02/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VelocityProcessorAuthWithToken.h"
#import "Address.h"
#import "AuthorizeTransaction.h"
#import "AVSData.h"
#import "BillingData.h"
#import "CardData.h"
#import "CardHolderName.h"
#import "CardSecurityData.h"
#import "CustomerData.h"
#import "ECommerceSecurityData.h"
#import "Email.h"
#import "IdentificationInformation.h"
#import "KeySerialNumber.h"
#import "PIN.h"
#import "ReportingData.h"
#import "TenderData.h"
#import "Track1Data.h"
#import "Transaction.h"
#import "TransactionData.h"
@protocol VelocityProcessorAdjustDelegate<NSObject>
@required
-(void)VelocityProcessorAdjustServerRequestFinishedWithSuccess:(id)successResponse;
-(void)VelocityProcessorAdjustServerRequestFailedWithErrorMessage:(id)failResponse;
@end
@interface VelocityProcessorAdjust : NSObject<NSURLSessionTaskDelegate,NSURLSessionDataDelegate>
@property (nonatomic, strong) id <VelocityProcessorAdjustDelegate> delegate;
-(void)adjustAppprofileid:(NSString *)appProfileID andMerchentID:(NSString *)merchantID andWorkFlowID:(NSString *)workDFlowID andSessionToken:(NSString *)sessionToken andIsTestAccount:(BOOL)isTestAccount;

@end
