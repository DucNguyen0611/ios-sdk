//
//  VelocityProcessor.h
//  VelocityCardSample
//
//  Created by Chetu on 1/19/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VelocityProcessorSignOn.h"
#import "VelocityProcessorAuthorizeTransaction.h"
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
#import "VelocityProcessorAuthWAndWOCapture.h"
@protocol VelocityProcessorDelegate<NSObject>
@required
-(void)VelocityProcessorFinishedWithSuccess:(id )successAny;
-(void)VelocityProcessorFailedWithErrorMessage:(id )failedAny;
@end

@interface VelocityProcessor : NSObject<VelocityProcessorSignOnDelegate,VelocityProcessorAuthTXDelegate,VelocityProcessorAuthWTokenDelegate,VelocityProcessorAuthNCaptureWAndWOTokenDelegate>{
  
}
@property (copy,nonatomic) NSString *vPIdentityToken;
@property (copy,nonatomic) NSString *vPAppProfileId;
@property (copy,nonatomic) NSString *vPMerchantProfileId;
@property (copy,nonatomic) NSString *vPWorkflowId;
@property (copy,nonatomic) NSString *vPSessionToken;
@property  BOOL vPIsTestAccount;
@property BOOL vPIsAuthWithPaymentDataToken;
@property (copy,nonatomic) NSString *vPPaymentAccountDataToken;
@property (strong,nonatomic) VelocityProcessorSignOn *obj;

@property (nonatomic, strong) id <VelocityProcessorDelegate> delegate;

    //Func for passing inital parameters to lib
- (void) initWith:(NSString *)identityToken forAppProfileId:(NSString *)appProfileId forMerchantProfileId:(NSString *)merchantProfileId forWorkflowId:(NSString *)workflowId andType:(BOOL )isTestAccount;
-(void)signOnWithIdentityToken;
-(void)verifyWithSessionToken;
-(void)createCardToken;
-(void)authorizeWithPaymentAccountDataToken;
-(void)authoriseWToken:(BOOL)isWithToken;
-(void)authAndCapture;
-(void)authNCaptureWithToken:(BOOL)isAuthNCaptureWithToken;
@end
