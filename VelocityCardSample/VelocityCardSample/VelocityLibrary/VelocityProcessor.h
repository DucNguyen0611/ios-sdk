//
//  VelocityProcessor.h
//  VelocityCardSample
//
//  Created by Chetu on 1/19/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//
/**
 * Main Velocity processor class of libraray
 *
 * 
 */
#import <Foundation/Foundation.h>
#import "VelocityProcessorSignOn.h"
#import "VelocityProcessorAuthorizeTransaction.h"
#import "VelocityProcessorAuthWithToken.h"
#import "VelocityProcessorCapture.h"
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
#import "VelocityProcessorVoid.h"
#import "VelocityProcessorAdjust.h"
#import "VelocityProcessorReturnByID.h"
#import "VelocityProcessorReturnUnlinked.h"
#import "VelocityQueryTransactionDetails.h"
#import "VelocityProcessorCaptureAll.h"
@protocol VelocityProcessorDelegate<NSObject>
@required
//delegate method for successful transaction
-(void)VelocityProcessorFinishedWithSuccess:(id )successAny;
//delegate method for Failed transaction
-(void)VelocityProcessorFailedWithErrorMessage:(id )failedAny;
@end

@interface VelocityProcessor : NSObject<VelocityProcessorSignOnDelegate,VelocityProcessorAuthTXDelegate,VelocityProcessorAuthWTokenDelegate,VelocityProcessorAuthNCaptureWAndWOTokenDelegate,VelocityProcessorCaptureDelegate,VelocityProcessorVoidDelegate,VelocityProcessorAdjustDelegate,VelocityProcessorReturnByIdDelegate,VelocityProcessorReturnUnLinkedDelegate,VelocityProcessorQueryTransactionDetailDelegate,VelocityProcessorCaptureAllDelegate>{
  
}
@property (strong,nonatomic) NSString *vPIdentityToken;
@property (strong,nonatomic) NSString *vPAppProfileId;
@property (strong,nonatomic) NSString *vPMerchantProfileId;
@property (strong,nonatomic) NSString *vPWorkflowId;
@property (strong,nonatomic) NSString *vPSessionToken;
@property  BOOL vPIsTestAccount;
@property BOOL vPIsAuthWithPaymentDataToken;
@property (strong,nonatomic) NSString *vPPaymentAccountDataToken;
@property (strong,nonatomic) VelocityProcessorSignOn *obj;

@property (nonatomic, strong) id <VelocityProcessorDelegate> delegate;

    //Func for passing inital parameters to lib
/**
 *  intialize velocity processor object with these parameter
 *
 *  @param identityToken
 *  @param appProfileId
 *  @param merchantProfileId
 *  @param workflowId
 *  @param isTestAccount
 *
 *  @return velocity processor object
 */
- (VelocityProcessor *) initWith:(NSString *)identityToken forAppProfileId:(NSString *)appProfileId forMerchantProfileId:(NSString *)merchantProfileId forWorkflowId:(NSString *)workflowId andSessionToken:(NSString *)sessiontoken andType:(BOOL )isTestAccount;
// method for user
/**
 *  method for calling sign on on the basis of bool value input
        if true call sign on else call verify method
 *
 *  @param isSignOn bool variable
 */
-(void)signON;
-(void)createCardToken;//used for calling sign on method
/**
 *  Call authorise with token and authorise without token method on the basis of bool value input if bool value == true then call auth with token otherwise call auth without token
 *
 *  @param isWithToken bool value
 */
-(void)authorise;
/**
 *  Call auth and capture method on the basis of bool value input if true it will call with token method and if false it will call without token method
 *
 *  @param isAuthNCaptureWithToken bool value
 */
-(void)authorizeAndCapture;
/**
 *  Call capture method for capturing transaction
 */
-(void)capture;
/**
 *  Call void or undo method
 */
-(void)undo;
/**
 *  Call adjust method to adjust transaction
 */
-(void)adjust;
/**
 *  Call return by id method
 */
-(void)returnById;
/**
 *  call sign on method and directly after calling sign on directly call returnunlinked without token method
 *  call returned unlinked method with token if bool value is true else call without token
 *  @param isWithToken
 */
-(void)returnUnlinked;

/**
 *  Call query transaction  detail method
 *
 *  @param
 */
-(void)queryTransactionsDetail;
/**
 *  Call CaptureAll   method
 *
 *  @param
 */
-(void)captureAll;

@end
