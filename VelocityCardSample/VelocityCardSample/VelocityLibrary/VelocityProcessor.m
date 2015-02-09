
    
//
//  VelocityProcessor.m
//  VelocityCardSample
//
//  Created by Chetu on 1/19/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "VelocityProcessor.h"
#import "VelocityProcessorConstant.h"
#import "VelocityPaymentTransaction.h"
#import "VelocityProcessorAuthorizeTransaction.h"
#import "ErrorPaymentResponse.h"
#import "BankcardTransactionResponsePro.h"
#import "VelocityResponse.h"


@implementation VelocityProcessor{
    BOOL isAuthWWOPaymentDataTokken;
    BOOL isAuthNCaptureWTokenCall;
    VelocityPaymentTransaction  *paymentObj;
    VelocityResponse *vRObj;
    BankcardTransactionResponsePro *bancardResp;
      ErrorPaymentResponse *errResobj;
    Address *addressObj;
    AuthorizeTransaction *authTransactionObj;
    AVSData *avsdataObj;
    BillingData *billingObj;
    CardData *carddataObj;
    CardHolderName *cardholderObj;
    CardSecurityData *cardsecurityObj;
    CustomerData *customerObj;
    ECommerceSecurityData *ecommerceObj;
    Email *emailObj;
    IdentificationInformation *identificationObj;
    KeySerialNumber *keyserialObj;
    PIN *pinObj;
    ReportingData *reportingdataObj;
    TenderData *tenderdataObj;
    Track1Data *track1dataObj;
    Transaction *transactionObj;
    TransactionData *transactiondataObj;
    
}
@synthesize vPIdentityToken;
@synthesize vPWorkflowId;
@synthesize vPAppProfileId;
@synthesize vPMerchantProfileId;
@synthesize vPIsTestAccount;
@synthesize vPSessionToken;
@synthesize obj;
@synthesize vPIsAuthWithPaymentDataToken;
@synthesize vPPaymentAccountDataToken;
#pragma mark-methods geting initial params
/*!
 *  @author sumit suman, 15-01-23 18:01:15
 *
 *  @brief  intialize the required variables for initiate process
 *  @param identityToken     
 *  @param appProfileId      
 *  @param merchantProfileId
 *  @param workflowId
 *  @param isTestAccount
 */
-(void)initWith:(NSString *)identityToken forAppProfileId:(NSString *)appProfileId forMerchantProfileId:(NSString *)merchantProfileId forWorkflowId:(NSString *)workflowId andType:(BOOL )isTestAccount{
    vPIdentityToken = identityToken;
    vPAppProfileId = appProfileId;
    vPWorkflowId = workflowId;
    vPMerchantProfileId = merchantProfileId;
    vPIsTestAccount = isTestAccount;
    //return[self signOnWithIdentityToken];
 
}



#pragma mark-methods For sign on
/*!
 *  @author sumit suman, 15-01-23 18:01:32
 *
 *  @brief  service for sign on method called here
 */
-(void)createCardToken{
    [self signOnWithIdentityToken];
}

-(void)signOnWithIdentityToken{
    
    obj=[[VelocityProcessorSignOn alloc]init];
    obj.delegate=self;
    [obj signOnWithIdentityToken:vPIdentityToken:vPIsTestAccount];
    
}



#pragma mark-SignON deligates
/*!
 *  @author sumit suman, 15-01-23 18:01:45
 *
 *  @brief  deligte methods of sign on
 *  @param successSessionToken returns sucess token for further processing of verification
 */
-(void)VelocityProcessorSignOnServerRequestFinishedWithSuccess:(NSString *)successSessionToken{
    
    vPSessionToken=successSessionToken;
     // Varify Token call and pass the token received from signon
    [self verifyWithSessionToken];
    //[self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:successSessionToken];
    
}

-(void)VelocityProcessorSignOnServerRequestFailedWithErrorMessage:(NSString *)failed{
    [self.delegate performSelector:@selector(VelocityProcessorFailedWithErrorMessage:) withObject:FAILEDMESSAGE];
}

/*!
 *  @author sumit suman, 15-02-09 18:02:16
 *
 *  @brief  verify method
 *  @return Payment account data token
 */
#pragma  mark-Verify session token
//method to verify session token
-(void)verifyWithSessionToken{
    VelocityProcessorAuthorizeTransaction *authTxObj=[[VelocityProcessorAuthorizeTransaction alloc] init];
    authTxObj.delegate=self;
    [authTxObj verifySessionTokenInXML:vPSessionToken forAppProfileId:vPAppProfileId forMerchantProfileId:vPMerchantProfileId forWorkflowId:vPWorkflowId andType:vPIsTestAccount];
}

#pragma mark-verify/AuthTransecion delegate
-(void)VelocityProcessorAuthTXServerRequestFailedWithErrorMessage:(id)failResponse{
    errResobj= [ErrorObjecthandler getmainObj];
    vRObj =[VelocityResponseObjectHandlers setModelObject:errResobj];
    if ([errResobj.errorId isEqualToString:@"5000"]) {
        [self createCardToken];
        
        return;
    }
    else
        
            [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:errResobj.ruleMessage];
    
    
}
-(void)VelocityProcessorAuthTXServerRequestFinishedWithSuccess:(id)successResponse{
    
    bancardResp=[ResponseObjecthandler getmainObj];
    vPPaymentAccountDataToken =bancardResp.paymentAccountDataToken;
    paymentObj = [PaymentObjecthandler getModelObject];
    paymentObj.paymentAccountDataToken=bancardResp.paymentAccountDataToken;
            vRObj =[VelocityResponseObjectHandlers setModelObject:bancardResp];
    if (isAuthWWOPaymentDataTokken) {
        if ([vRObj.status isEqualToString:@"Successful"]) {
            [self authorizeWithPaymentAccountDataToken];
        }
        else
            [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
        
    }
    else if (isAuthNCaptureWTokenCall){
        if ([vRObj.status isEqualToString:@"Successful"])
        [self authAndCapture];
        else
            [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
    }
    else
    
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}

/*!
 *  @author sumit suman, 15-02-09 18:02:28
 *
 *  @brief  AuthWithToken And AuthWIthoutTOken method
 *  @return Authorization of transaction
 */
#pragma mark-authwithToken
-(void)authorizeWithPaymentAccountDataToken{
    
    VelocityProcessorAuthWithToken * authObj=[[VelocityProcessorAuthWithToken alloc]init];
    authObj.delegate=self;
   [authObj authorizeWithTokenAndAppprofileid:vPAppProfileId andMerchentID:vPMerchantProfileId andWorkFlowID:vPWorkflowId andSessionToken:vPSessionToken andIsTestAccount:vPIsTestAccount andIsWithToken:vPIsAuthWithPaymentDataToken withModalObjectsAddress:addressObj authoriseTransaction:authTransactionObj andAvsData:avsdataObj andBillingData:billingObj and:carddataObj and:cardholderObj and:cardsecurityObj and:customerObj and:ecommerceObj and:reportingdataObj and:tenderdataObj and:track1dataObj and:transactionObj and:transactiondataObj];
   
}
-(void)authoriseWToken:(BOOL)isWithToken{
    isAuthWWOPaymentDataTokken=YES;
    isAuthNCaptureWTokenCall=NO;
    vPIsAuthWithPaymentDataToken =isWithToken;
    [self signOnWithIdentityToken];
}

#pragma authW/WithoutToken Delegate
-(void)VelocityProcessorAuthWTokenServerRequestFinishedWithSuccess:(id)successResponse{
     vRObj =[VelocityResponseObjectHandlers setModelObject:bancardResp];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}
-(void)VelocityProcessorAuthAuthWTokenServerRequestFailedWithErrorMessage:(id)failResponse{
     vRObj =[VelocityResponseObjectHandlers setModelObject:errResobj];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}
/*!
 *  @author sumit suman, 15-02-09 18:02:15
 *
 *  @brief  Auth and Capture method with and without token
 *  @return capture states
 */
#pragma mark Auth&Caputre With/Without Token
-(void)authAndCapture;{
    VelocityProcessorAuthWAndWOCapture *authNCaptureObj=[[VelocityProcessorAuthWAndWOCapture alloc]init];
    authNCaptureObj.delegate=self;
    [authNCaptureObj authorizeAndCaptureWithTokenAndAppprofileid:vPAppProfileId andMerchentID:vPMerchantProfileId andWorkFlowID:vPWorkflowId andSessionToken:vPSessionToken andIsTestAccount:vPIsTestAccount andIsWithToken:vPIsAuthWithPaymentDataToken withModalObjectsAddress:addressObj authoriseTransaction:authTransactionObj andAvsData:avsdataObj andBillingData:billingObj and:carddataObj and:cardholderObj and:cardsecurityObj and:customerObj and:ecommerceObj and:reportingdataObj and:tenderdataObj and:track1dataObj and:transactionObj and:transactiondataObj];
    
}

-(void)authNCaptureWithToken:(BOOL)isAuthNCaptureWithToken{
    isAuthNCaptureWTokenCall=YES;
    isAuthWWOPaymentDataTokken=NO;
    vPIsAuthWithPaymentDataToken =isAuthNCaptureWithToken;
    [self signOnWithIdentityToken];
   
}
#pragma mark-AuthNCapture delegates
-(void)VelocityProcessorAuthNCaptureWTokenServerRequestFinishedWithSuccess:(id)successResponse{
    vRObj =[VelocityResponseObjectHandlers setModelObject:bancardResp];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}
-(void)VelocityProcessorAuthNCaptureWTokenServerRequestFailedWithErrorMessage:(id)failResponse{
    vRObj =[VelocityResponseObjectHandlers setModelObject:errResobj];
        [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}


@end
