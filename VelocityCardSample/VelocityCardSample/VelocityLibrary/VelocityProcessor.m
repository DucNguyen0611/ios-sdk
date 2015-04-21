
    
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
#import "BancardCaptureResponse.h"
#import "VelocityQueryTransactionDetails.h"
#import "TransactionDetailModalClass.h"
#import "CaptureAllArrayOfResponse.h"


@implementation VelocityProcessor{
    BOOL checkSignON;
    BOOL isAuthWWOPaymentDataTokken;
    BOOL isAuthNCaptureWTokenCall;
    BOOL isCapture;
    BOOL isVoid;
    
    VelocityPaymentTransaction  *paymentObj;
    VelocityResponse *vRObj;
    BankcardTransactionResponsePro *bancardResp;
      ErrorPaymentResponse *errResobj;
    BancardCaptureResponse *captureResponseObj;
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
    NSInteger switchcaseInput;

    TransactionDetailModalClass * transectionDetailsObject;
    CaptureAllArrayOfResponse *captureAllArrayResponseObject;
    
}
@synthesize vPIdentityToken;//stores identity token
@synthesize vPWorkflowId;//stores work flow id
@synthesize vPAppProfileId;//stores app profile id
@synthesize vPMerchantProfileId;//stores merchant profile id
@synthesize vPIsTestAccount;//check whether test account or not
@synthesize vPSessionToken;//stores session token
@synthesize obj;
@synthesize vPIsAuthWithPaymentDataToken;//check whether with payment account datatoken or not for aut with token method
@synthesize vPPaymentAccountDataToken;//check whether with payment account data token or not for authncapture method
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
- (VelocityProcessor *) initWith:(NSString *)identityToken forAppProfileId:(NSString *)appProfileId forMerchantProfileId:(NSString *)merchantProfileId forWorkflowId:(NSString *)workflowId andSessionToken:(NSString *)sessiontoken andType:(BOOL )isTestAccount{
    vPIdentityToken = identityToken;
    vPAppProfileId = appProfileId;
    vPWorkflowId = workflowId;
    vPMerchantProfileId = merchantProfileId;
    vPIsTestAccount = isTestAccount;
    if (sessiontoken ==Nil) {
       
    }
  else
      vPSessionToken = sessiontoken;
    
    return self;
}



#pragma mark-methods For sign on
/*!
 *  @author sumit suman, 15-01-23 18:01:32
 *
 *  @brief  service for sign on method called here with bool value =1
            and verify will be called for bool value =0
 */
-(void)signON{
    switchcaseInput = 0;
    [self signOnWithIdentityToken];
}
-(void)createCardToken{
    switchcaseInput = 1;
    [self signOnWithIdentityToken];
}

-(void)signOnWithIdentityToken{
    
    obj = [[VelocityProcessorSignOn alloc]init];
    obj.delegate = self;
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
    
    vPSessionToken = successSessionToken;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:vPSessionToken,@"SessionToken", nil];
         switch (switchcaseInput ) {
        case 0:
            /**
             *  Calling creat card token method for signon
             */
            
            [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:dict];
            
            //[velocityProcessorObj createCardTokenIsOnlySignOn:YES];
            break;
        case 1:
            /**
             *  Calling creat card token method for verify
             */
            [self verifyXML];
            
            break;
        case 2:
            /**
             *  Calling Authwith token method
             */
            [self authorizeXML];
            break;
        case 3:
            /**
             *  calling authwithout token method
             */
           [self authorizeXML];
            break;
        case 4:
            /**
             *  calling auth and capture method with token
             */
            [self authorizeAndCaptureXML];
            
            break;
        case 5:
            /**
             *  calling auth and capture method with out token
             */
                 [self authorizeAndCaptureXML];
            
            break;
        case 6:
            /**
             *  calling capture method
             */
                 [self captureXML];
            break;
        case 7:
            /**
             *  calling void method
             */
                 [self undoXML];
            break;
        case 8:
            /**
             *  calling adjust method
             */
                 [self adjustXML];
            break;
        case 9:
            /**
             *  calling return by id method
             */
                 [self returnByIdXML];
            break;
        case 10:
            /**
             *  calling returned unlinked method
             */
                 [self returnUnlinkedXML:YES];
            break;
        case 11:
            /**
             *  calling returned unlinked method without token
             */
           [self returnUnlinkedXML:NO];
            break;
        case 12:
                 /**
                  *  calling queryTransactionDetails Method
                  */
                 [self queryTransactionDetails];
                 break;
        case 13:
                 /**
                  *  calling queryTransactionDetails Method
                  */
                 [self captureAllXML];
                 break;
        default:
            break;
            
    }
     //[self verifyXML];
    
    
}

-(void)VelocityProcessorSignOnServerRequestFailedWithErrorMessage:(NSString *)failed{
    errResobj = [ErrorObjecthandler getmainObj];
    if ([errResobj.errorId isEqualToString:@"5000"]) {
        [self signOnWithIdentityToken];
        
        
    }
    
    [self.delegate performSelector:@selector(VelocityProcessorFailedWithErrorMessage:) withObject:failed];
}

/*!
 *  @author sumit suman, 15-02-09 18:02:16
 *
 *  @brief  verify method
 *  @return Payment account data token
 */
#pragma  mark-Verify session token
//method to verify session token
-(void)verifyXML{
    
    VelocityProcessorAuthorizeTransaction *authTxObj =[[VelocityProcessorAuthorizeTransaction alloc] init];
    authTxObj.delegate = self;
    [authTxObj verifySessionTokenInXML:vPSessionToken forAppProfileId:vPAppProfileId forMerchantProfileId:vPMerchantProfileId forWorkflowId:vPWorkflowId andType:vPIsTestAccount];
}

#pragma mark-verify/AuthTransecion delegate
-(void)VelocityProcessorAuthTXServerRequestFailedWithErrorMessage:(id)failResponse{
    errResobj = [ErrorObjecthandler getmainObj];
    vRObj = [VelocityResponseObjectHandlers setModelObject:errResobj];
    if ([errResobj.errorId isEqualToString:@"5000"]) {
        [self signOnWithIdentityToken];
        
       
    }
    else{
       
        if (errResobj.errorId!=nil && ![failResponse isKindOfClass:[NSError class]]) {
            
            vRObj = [VelocityResponseObjectHandlers setModelObject:errResobj];
            [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
        }
        else
            [self.delegate performSelector:@selector(VelocityProcessorFailedWithErrorMessage:) withObject:@"Not Verified or server error"];
    }
        
    
    
    
}
-(void)VelocityProcessorAuthTXServerRequestFinishedWithSuccess:(id)successResponse{
    
    bancardResp = [ResponseObjecthandler getmainObj];
    vRObj = [VelocityResponseObjectHandlers setModelObject:bancardResp];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}

/*!
 *  @author sumit suman, 15-02-09 18:02:28
 *
 *  @brief  AuthWithToken And AuthWIthoutTOken method
 *  @return Authorization of transaction
 */
#pragma mark-authwithToken
-(void)authorise{
   paymentObj = [PaymentObjecthandler getModelObject];
    if (paymentObj.paymentAccountDataToken .length>0)
    { switchcaseInput = 2;
    
        vPIsAuthWithPaymentDataToken= YES;
    }
    else{
        switchcaseInput = 3;
     
        vPIsAuthWithPaymentDataToken = NO;
    }
   
    [self signOnWithIdentityToken];
}

-(void)authorizeXML{
    
    VelocityProcessorAuthWithToken * authObj =[[VelocityProcessorAuthWithToken alloc]init];
    authObj.delegate = self;
   [authObj authorizeWithTokenAndAppprofileid:vPAppProfileId andMerchentID:vPMerchantProfileId andWorkFlowID:vPWorkflowId andSessionToken:vPSessionToken andIsTestAccount:vPIsTestAccount andIsWithToken:vPIsAuthWithPaymentDataToken withModalObjectsAddress:addressObj authoriseTransaction:authTransactionObj andAvsData:avsdataObj andBillingData:billingObj and:carddataObj and:cardholderObj and:cardsecurityObj and:customerObj and:ecommerceObj and:reportingdataObj and:tenderdataObj and:track1dataObj and:transactionObj and:transactiondataObj];
   
}

#pragma authW/WithoutToken Delegate
-(void)VelocityProcessorAuthWTokenServerRequestFinishedWithSuccess:(id)successResponse{
    bancardResp = [ResponseObjecthandler getmainObj];
     vRObj = [VelocityResponseObjectHandlers setModelObject:bancardResp];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}
-(void)VelocityProcessorAuthAuthWTokenServerRequestFailedWithErrorMessage:(id)failResponse{
     errResobj = [ErrorObjecthandler getmainObj];
    if (errResobj.errorId!=nil && ![failResponse isKindOfClass:[NSError class]]) {
        
        vRObj = [VelocityResponseObjectHandlers setModelObject:errResobj];
        [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
    }
    else
    [self.delegate performSelector:@selector(VelocityProcessorFailedWithErrorMessage:) withObject:@"Not Verified or server error"];
}
/*!
 *  @author sumit suman, 15-02-09 18:02:15
 *
 *  @brief  Auth and Capture method with and without token
 *  @return capture states
 */
#pragma mark Auth&Caputre With/Without Token
-(void)authorizeAndCaptureXML{
   
    VelocityProcessorAuthWAndWOCapture *authNCaptureObj=[[VelocityProcessorAuthWAndWOCapture alloc]init];
    authNCaptureObj.delegate = self;
    [authNCaptureObj authorizeAndCaptureWithTokenAndAppprofileid:vPAppProfileId andMerchentID:vPMerchantProfileId andWorkFlowID:vPWorkflowId andSessionToken:vPSessionToken andIsTestAccount:vPIsTestAccount andIsWithToken:vPIsAuthWithPaymentDataToken withModalObjectsAddress:addressObj authoriseTransaction:authTransactionObj andAvsData:avsdataObj andBillingData:billingObj and:carddataObj and:cardholderObj and:cardsecurityObj and:customerObj and:ecommerceObj and:reportingdataObj and:tenderdataObj and:track1dataObj and:transactionObj and:transactiondataObj];
    
}

-(void)authorizeAndCapture{
    paymentObj = [PaymentObjecthandler getModelObject];
    if (paymentObj.paymentAccountDataToken .length>0)
    { switchcaseInput = 4;
        
        vPIsAuthWithPaymentDataToken = YES;
    }
    else{
        switchcaseInput = 5;
        
        vPIsAuthWithPaymentDataToken = NO;
    }
   [self signOnWithIdentityToken];
   
}
#pragma mark-AuthNCapture delegates
-(void)VelocityProcessorAuthNCaptureWTokenServerRequestFinishedWithSuccess:(id)successResponse{
    bancardResp = [ResponseObjecthandler getmainObj];
    vRObj = [VelocityResponseObjectHandlers setModelObject:bancardResp];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:vRObj.status];
}
-(void)VelocityProcessorAuthNCaptureWTokenServerRequestFailedWithErrorMessage:(id)failResponse{
    errResobj = [ErrorObjecthandler getmainObj];
    if (errResobj.errorId!=nil && ![failResponse isKindOfClass:[NSError class]]) {
        
        vRObj = [VelocityResponseObjectHandlers setModelObject:errResobj];
        [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
    }
    else
        [self.delegate performSelector:@selector(VelocityProcessorFailedWithErrorMessage:) withObject:@"Not Verified or server error"];
}
/**
 *  Capture Method and its delegates
 *
 *  This method is used for capturing any autrorised value and stores its response into BancardCaptureResponse
 */
#pragma mark-Capture method and its delegate
-(void)capture{
    switchcaseInput = 6;
     [self signOnWithIdentityToken];
    

}
-(void)captureXML{
    
    VelocityProcessorCapture *captureObj = [[VelocityProcessorCapture alloc]init];
    captureObj.delegate = self;
    [captureObj captureAndAppprofileid:vPAppProfileId andMerchentID:vPMerchantProfileId andWorkFlowID:vPWorkflowId andSessionToken:vPSessionToken andIsTestAccount:vPIsTestAccount];
}
-(void)VelocityProcessorCaptureServerRequestFinishedWithSuccess:(id)successResponse{
    captureResponseObj = [BancardCaptureObjecthandler getmainObj];
    vRObj = [VelocityResponseObjectHandlers setModelObject:captureResponseObj];
    vRObj = [VelocityResponseObjectHandlers getModelObject];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:vRObj.status];
    

}
-(void)VelocityProcessorCaptureServerRequestFailedWithErrorMessage:(id)failResponse{
    captureResponseObj = [BancardCaptureObjecthandler getmainObj];
    vRObj = [VelocityResponseObjectHandlers setModelObject:errResobj];
    errResobj = [ErrorObjecthandler getmainObj];
    if (errResobj.errorId!=nil && ![failResponse isKindOfClass:[NSError class]]) {
        
        vRObj = [VelocityResponseObjectHandlers setModelObject:errResobj];
        [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
    }
    else
        [self.delegate performSelector:@selector(VelocityProcessorFailedWithErrorMessage:) withObject:@"Not Verified or server error"];
}
/**
 *  Undo/Void Method and its success and faileur delegates
 *
 *   This method is callled for Undo any captured transection
 */
#pragma mark- void or undo transaction and its delegate
-(void)undo{
    switchcaseInput = 7;
    [self signOnWithIdentityToken];
    
}
-(void)undoXML{
    VelocityProcessorVoid *voidObj=[[VelocityProcessorVoid alloc]init ];
    voidObj.delegate = self;
    [voidObj voidAppprofileid:vPAppProfileId andMerchentID:vPMerchantProfileId andWorkFlowID:vPWorkflowId andSessionToken:vPSessionToken andIsTestAccount:vPIsTestAccount];
}
-(void)VelocityProcessorVoidServerRequestFinishedWithSuccess:(id)successResponse{
    bancardResp = [ResponseObjecthandler getmainObj];
    vRObj = [VelocityResponseObjectHandlers setModelObject:bancardResp];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}
-(void)VelocityProcessorVoidServerRequestFailedWithErrorMessage:(id)failResponse{
    errResobj = [ErrorObjecthandler getmainObj];
    
    if (errResobj.errorId!=nil&& ![failResponse isKindOfClass:[NSError class]]) {
        
        vRObj = [VelocityResponseObjectHandlers setModelObject:errResobj];
        [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
    }
    else
        [self.delegate performSelector:@selector(VelocityProcessorFailedWithErrorMessage:) withObject:@"Not Verified or server error"];
}
/**
 *  Adjust Method and its Delegates
 *
 *  @ This method is used for Adjusting any Authorised amount
 */
#pragma mark-Adjust Transaction method


-(void)adjust{
    switchcaseInput = 8;
    [self signOnWithIdentityToken];
    
}

-(void)adjustXML{
    VelocityProcessorAdjust *adjustObj = [[VelocityProcessorAdjust alloc]init ];
    adjustObj.delegate = self;
    [adjustObj adjustAppprofileid:vPAppProfileId andMerchentID:vPMerchantProfileId andWorkFlowID:vPWorkflowId andSessionToken:vPSessionToken andIsTestAccount:vPIsTestAccount];
}
-(void)VelocityProcessorAdjustServerRequestFinishedWithSuccess:(id)successResponse{
    bancardResp = [ResponseObjecthandler getmainObj];
    vRObj = [VelocityResponseObjectHandlers setModelObject:bancardResp];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];

}
-(void)VelocityProcessorAdjustServerRequestFailedWithErrorMessage:(id)failResponse{
    errResobj = [ErrorObjecthandler getmainObj];
    vRObj =[VelocityResponseObjectHandlers setModelObject:errResobj];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}
/**
 *  Return BY ID method and its delegates
 *
 *  @ This method is used for refund of any authorised amount using BatchID and TransectionD
 */
#pragma mark-ReturByID  method
-(void)returnById{
    switchcaseInput = 9;
    [self signOnWithIdentityToken];
    
    
}
-(void)returnByIdXML{
    VelocityProcessorReturnByID *returnByidObj = [[VelocityProcessorReturnByID alloc] init];
    returnByidObj.delegate = self;
    [returnByidObj returnByIdAppprofileid:vPAppProfileId andMerchentID:vPMerchantProfileId andWorkFlowID:vPWorkflowId andSessionToken:vPSessionToken andIsTestAccount:vPIsTestAccount];
}
-(void)VelocityProcessorReturnByIdServerRequestFinishedWithSuccess:(id)successResponse{
    bancardResp = [ResponseObjecthandler getmainObj];
    vRObj = [VelocityResponseObjectHandlers setModelObject:bancardResp];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}
-(void)VelocityProcessorReturnByIdServerRequestFailedWithErrorMessage:(id)failResponse{
    errResobj = [ErrorObjecthandler getmainObj];
    vRObj = [VelocityResponseObjectHandlers setModelObject:errResobj];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}
/**
 *  ReturnedUnlinked Method and returnUnlinked without token method
 *
 *  @ ReturnedUnlinked Method  method is used for return any authorised transection without any transection id,it uses user information like card holder name ,cvc etc.Main Parameter is PaymentAccount Datatoken
    ReturnedUnlinked Method without payment account datatoken method is used for return any authorised transection without any transection id,it uses user information like card holder name ,cvc etc. PaymentAccount Datatoken is not required
 */
#pragma mark-ReturUnLinked  method
-(void)returnUnlinked{
    paymentObj = [PaymentObjecthandler getModelObject];
    if (paymentObj.paymentAccountDataToken .length>0){
       switchcaseInput = 10;
        }
    else
    switchcaseInput = 11;
    
    [self signOnWithIdentityToken];
    
}
-(void)returnUnlinkedXML:(BOOL)isWithtoken{
    VelocityProcessorReturnUnlinked *returnUnlinkedObj=[[VelocityProcessorReturnUnlinked alloc]init];
    returnUnlinkedObj.delegate = self;
    [returnUnlinkedObj returnUnLinkedAppprofileid:vPAppProfileId andMerchentID:vPMerchantProfileId andWorkFlowID:vPWorkflowId andSessionToken:vPSessionToken andIsWithToken:isWithtoken andIsTestAccount:vPIsTestAccount];
}
-(void)VelocityProcessorReturnUnLinkedServerRequestFinishedWithSuccess:(id)successResponse{
    bancardResp = [ResponseObjecthandler getmainObj];
    vRObj = [VelocityResponseObjectHandlers setModelObject:bancardResp];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}
-(void)VelocityProcessorReturnUnLinkedServerRequestFailedWithErrorMessage:(id)failResponse{
    errResobj = [ErrorObjecthandler getmainObj];
    vRObj = [VelocityResponseObjectHandlers setModelObject:errResobj];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}
#pragma mark-QueryTransactionDetails  method
-(void)queryTransactionsDetail{
    switchcaseInput = 12;
    [self signOnWithIdentityToken];
}
-(void)queryTransactionDetails{
    VelocityQueryTransactionDetails *queryObject = [[VelocityQueryTransactionDetails alloc] init];
    queryObject.delegate = self;
    [queryObject queryTransactionDetailsAppprofileid:vPAppProfileId andMerchentID:vPMerchantProfileId andWorkFlowID:vPWorkflowId andSessionToken:vPSessionToken andIsTestAccount:vPIsTestAccount
     
     ];
    
}
-(void)VelocityProcessorQueryTransactionDetailServerRequestFinishedWithSuccess:(id)successResponse{
    transectionDetailsObject = [TransactionDetailObjecthandler getModelObject];
    vRObj = [VelocityResponseObjectHandlers setModelObject:transectionDetailsObject];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
}
-(void)VelocityProcessorQueryTransactionDetailServerRequestFailedWithErrorMessage:(id)failResponse{
    errResobj = [ErrorObjecthandler getmainObj];
    vRObj =[VelocityResponseObjectHandlers setModelObject:errResobj];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:errResobj.errorId];
}

#pragma mark-CaptureAll  method
-(void)captureAll{
    switchcaseInput = 13;
    [self signOnWithIdentityToken];
}
-(void)captureAllXML{
    VelocityProcessorCaptureAll * captureAllObject = [[VelocityProcessorCaptureAll alloc]init];
    captureAllObject.delegate = self;
    [captureAllObject CaptureAllWithsAppprofileid:vPAppProfileId andMerchentID:vPMerchantProfileId andWorkFlowID:vPWorkflowId andSessionToken:vPSessionToken andIsTestAccount:vPIsTestAccount];
    
}
-(void)VelocityProcessorCaptureAllServerRequestFinishedWithSuccess:(id)successResponse{
    captureAllArrayResponseObject = [CaptureAllArrayOfResponseObjecthandler getmainObj];
    vRObj =[VelocityResponseObjectHandlers setModelObject:captureAllArrayResponseObject];
    vRObj=[VelocityResponseObjectHandlers getModelObject];
    [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:vRObj.status];
    
    
}
-(void)VelocityProcessorCaptureAllServerRequestFailedWithErrorMessage:(id)failResponse{
    
    vRObj = [VelocityResponseObjectHandlers setModelObject:errResobj];
    errResobj = [ErrorObjecthandler getmainObj];
    if (errResobj.errorId!=nil && ![failResponse isKindOfClass:[NSError class]]) {
        
        vRObj = [VelocityResponseObjectHandlers setModelObject:errResobj];
        [self.delegate performSelector:@selector(VelocityProcessorFinishedWithSuccess:) withObject:bancardResp.status];
    }
    else
        [self.delegate performSelector:@selector(VelocityProcessorFailedWithErrorMessage:) withObject:@"Not Verified or server error"];
}
@end

