//
//  VelocityProcessorReturnUnlinked.h
//  VelocityCardSample
//
//  Created by Chetu on 12/02/15.
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
@protocol VelocityProcessorReturnUnLinkedDelegate<NSObject>
@required
-(void)VelocityProcessorReturnUnLinkedServerRequestFinishedWithSuccess:(id)successResponse;
-(void)VelocityProcessorReturnUnLinkedServerRequestFailedWithErrorMessage:(id)failResponse;
@end
@interface VelocityProcessorReturnUnlinked : NSObject<NSURLSessionTaskDelegate,NSURLSessionDataDelegate>
@property (nonatomic, strong) id <VelocityProcessorReturnUnLinkedDelegate> delegate;
-(void)returnUnLinkedAppprofileid:(NSString *)appProfileID andMerchentID:(NSString *)merchantID andWorkFlowID:(NSString *)workDFlowID andSessionToken:(NSString *)sessionToken andIsWithToken:(BOOL)isWithToken andIsTestAccount:(BOOL)isTestAccount;

@end
