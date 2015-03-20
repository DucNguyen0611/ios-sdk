//
//  VelocityProcessorAuthWithToken.h
//  VelocityCardSample
//
//  Created by Chetu on 02/02/15.
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

@protocol VelocityProcessorAuthWTokenDelegate<NSObject>
@required
-(void)VelocityProcessorAuthWTokenServerRequestFinishedWithSuccess:(id)successResponse;
-(void)VelocityProcessorAuthAuthWTokenServerRequestFailedWithErrorMessage:(id)failResponse;
@end

@interface VelocityProcessorAuthWithToken : NSObject<NSURLSessionTaskDelegate,NSURLSessionDataDelegate>
@property (nonatomic, weak) id <VelocityProcessorAuthWTokenDelegate> delegate;
//-(void)authorizeWithTokenAndAppprofileid:(NSString *)appProfileID andMerchentID:(NSString *)merchantID andWorkFlowID:(NSString *)workDFlowID andSessionToken:(NSString *)sessionToken andPaymentAccountDataToken:(NSString *)paymentDataToken andIsTestAccount:(BOOL)isTestAccount;

-(void)authorizeWithTokenAndAppprofileid:(NSString *)appProfileID andMerchentID:(NSString *)merchantID andWorkFlowID:(NSString *)workDFlowID andSessionToken:(NSString *)sessionToken andIsTestAccount:(BOOL)isTestAccount andIsWithToken:(BOOL)isWithToken withModalObjectsAddress:(Address *)addressObj authoriseTransaction:(AuthorizeTransaction *)authTxObj andAvsData:(AVSData *)avsObj andBillingData:(BillingData *)billingDataObj and:(CardData *)cardDataObj and:(CardHolderName *)cardholderObj and:(CardSecurityData *)cardsecurityObj and:(CustomerData *)customerDataObj and:(ECommerceSecurityData *)ecommerceObj and:(ReportingData*)reportingDataObj and:(TenderData *)trnderDataObj and:(Track1Data *)track1dataObj and:(Transaction *)transactionObj and:(TransactionData *)transectionDataObj;
@end















