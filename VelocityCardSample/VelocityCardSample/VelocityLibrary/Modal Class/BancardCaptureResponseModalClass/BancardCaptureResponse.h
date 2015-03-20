//
//  BancardCaptureResponse.h
//  VelocityCardSample
//
//  Created by Chetu on 10/02/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BancardCaptureResponse : NSObject
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSString *statusCode;
@property (strong,nonatomic) NSString *statusMessage;
@property (strong,nonatomic) NSString *transactionId;
@property (strong,nonatomic) NSString *originatorTransactionId;
@property (strong,nonatomic) NSString *serviceTransactionId;
@property (strong,nonatomic) NSString *serviceTransactionDateTime;
@property (strong,nonatomic) NSString *captureState;
@property (strong,nonatomic) NSString *transactionState;
@property BOOL isacknowledged;
@property (strong,nonatomic) NSString *prepaidCard;
@property (strong,nonatomic) NSString *reference;
@property (strong,nonatomic) NSString *netAmount;
@property (strong,nonatomic) NSString *cardType;
@property (strong,nonatomic) NSString *approvalCode;
@property (strong,nonatomic) NSString *batchId;
@property (strong,nonatomic) NSString *industryType;
@property (strong,nonatomic) NSString *cVResult;
@property (strong,nonatomic) NSString *paymentAccountDataToken;
@property (strong,nonatomic) NSString *count;
@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSString *time;
@property (strong,nonatomic) NSString *timeZone;
@property (strong,nonatomic) NSString *httpCode;
@end

@interface BancardCaptureObjecthandler : NSObject
/**
 *  to set values in the modal class call this method with dictionary
 *
 *  @param nsdictionary type
 *
 *  @return object
 */
+(BancardCaptureResponse *)setModelObjectWithDic:(NSDictionary*)dict;
/**
 *  set single value in the modal class using this method
 *
 *  @return object of modal class
 */
+(BancardCaptureResponse *)getModelObject;
/**
 *  to retrive value from modal class call this method
 *
 *  @return object type
 */
+(BancardCaptureResponse *)getmainObj;
@end
