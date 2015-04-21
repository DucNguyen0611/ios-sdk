//
//  VelocityResponseModalClass.h
//  VelocityCardSample
//
//  Created by Chetu on 27/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankcardTransactionResponsePro : NSObject
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSString *statusCode;
@property (strong,nonatomic) NSString *statusMessage;
@property (strong,nonatomic) NSString *transactionId;
@property (strong,nonatomic) NSString *originatorTransactionId;
@property (strong,nonatomic) NSString *serviceTransactionId;
//@property (strong,nonatomic) NSString *serviceTransactionDateTime;
@property (strong,nonatomic) NSString *captureState;
@property (strong,nonatomic) NSString *transactionState;
@property  BOOL acknowledged;
@property (strong,nonatomic) NSString *prepaidCard;
@property (strong,nonatomic) NSString *reference;
@property (strong,nonatomic) NSString *amount;
@property (strong,nonatomic) NSString *cardType;
@property (strong,nonatomic) NSString *feeAmount;
@property (strong,nonatomic) NSString *approvalCode;
@property (strong,nonatomic) NSString *aVSResult;
@property (strong,nonatomic) NSString *batchId;
@property (strong,nonatomic) NSString *cVResult;
@property (strong,nonatomic) NSString *cardLevel;
@property (strong,nonatomic) NSString *downgradeCode;
@property (strong,nonatomic) NSString *maskedPAN;
@property (strong,nonatomic) NSString *paymentAccountDataToken ;
@property (strong,nonatomic) NSString *retrievalReferenceNumber;
@property (strong,nonatomic) NSString *adviceResponse;
@property (strong,nonatomic) NSString *commercialCardResponse;
@property (strong,nonatomic) NSString *returnedACI;
@property (strong,nonatomic) NSString *statusHttpResponse;
@property (strong,nonatomic) NSString *statusCodeHttpResponse;
@property (strong,nonatomic) NSString *orderId;
@property (strong,nonatomic) NSString *settlementDate;
@property (strong,nonatomic) NSString *finalBalance;
@property (strong,nonatomic) NSString *cashBackAmount;
//- (id)initWithResponseDict:(NSDictionary *)dict ;
@end

@interface ServiceTransactionDateTime : NSObject
@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSString *time;
@property (strong,nonatomic) NSString *timeZone;
@end

@interface ResponseObjecthandler : NSObject
/**
 *  to set values in the modal class call this method with dictionary
 *
 *  @param nsdictionary type
 *
 *  @return object
 */

+(BankcardTransactionResponsePro *)getModelObjectWithDic:(NSDictionary*)dict;
/**
 *  to set values in the modal class call this method
 *
 *
 *
 *  @return object
 */

+(BankcardTransactionResponsePro *)getModelObject;
/**
 *  to get values from  modal class
 *
 *
 *
 *  @return object
 */

+(BankcardTransactionResponsePro *)getmainObj;

@end