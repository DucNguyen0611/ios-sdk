//
//  VelocityProcessorAuthWAndWOCapture.h
//  VelocityCardSample
//
//  Created by Amit Aman on 09/02/15.
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
@protocol VelocityProcessorAuthNCaptureWAndWOTokenDelegate<NSObject>
@required
-(void)VelocityProcessorAuthNCaptureWTokenServerRequestFinishedWithSuccess:(id)successResponse;
-(void)VelocityProcessorAuthNCaptureWTokenServerRequestFailedWithErrorMessage:(id)failResponse;
@end

@interface VelocityProcessorAuthWAndWOCapture : NSObject<NSURLSessionTaskDelegate,NSURLSessionDataDelegate>
@property (nonatomic, strong) id <VelocityProcessorAuthNCaptureWAndWOTokenDelegate> delegate;
-(void)authorizeAndCaptureWithTokenAndAppprofileid:(NSString *)appProfileID andMerchentID:(NSString *)merchantID andWorkFlowID:(NSString *)workDFlowID andSessionToken:(NSString *)sessionToken andIsTestAccount:(BOOL)isTestAccount andIsWithToken:(BOOL)isWithToken withModalObjectsAddress:(Address *)addressObj authoriseTransaction:(AuthorizeTransaction *)authTxObj andAvsData:(AVSData *)avsObj andBillingData:(BillingData *)billingDataObj and:(CardData *)cardDataObj and:(CardHolderName *)cardholderObj and:(CardSecurityData *)cardsecurityObj and:(CustomerData *)customerDataObj and:(ECommerceSecurityData *)ecommerceObj and:(ReportingData*)reportingDataObj and:(TenderData *)trnderDataObj and:(Track1Data *)track1dataObj and:(Transaction *)transactionObj and:(TransactionData *)transectionDataObj;
@end
