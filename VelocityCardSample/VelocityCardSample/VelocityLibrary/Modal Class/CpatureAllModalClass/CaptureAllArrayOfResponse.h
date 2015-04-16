//
//  CaptureAllArrayOfResponse.h
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 31/03/15.


//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CaptureAllArrayOfResponse : NSObject
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSString *httpCode;
@property (strong,nonatomic) NSString *statusCode;
@property (strong,nonatomic) NSString *statusMessage;
@property (strong,nonatomic) NSString *transactionId;
@property (strong,nonatomic) NSString *originatorTransactionId;
@property (strong,nonatomic) NSString *serviceTransactionId;
@property (strong,nonatomic) NSString *serviceTransactionDateTime;
@property (strong,nonatomic) NSString *addendum;
@property (strong,nonatomic) NSString *captureState;
@property (strong,nonatomic) NSString *transactionState;
@property (strong,nonatomic) NSString *reference;
@property (strong,nonatomic) NSString *batchId;
@property (strong,nonatomic) NSString *industryType;
@property (strong,nonatomic) NSString *PrepaidCard;
@property (strong,nonatomic) NSDictionary *cashBackTotals;
@property (strong,nonatomic) NSDictionary *netTotals;
@property (strong,nonatomic) NSDictionary *pINDebitReturnTotals;
@property (strong,nonatomic) NSDictionary *pINDebitSaleTotals;
@property (strong,nonatomic) NSDictionary *returnTotals;
@property (strong,nonatomic) NSDictionary *saleTotals;
@property (strong,nonatomic) NSDictionary *voidTotals;
@property (strong,nonatomic) NSDictionary *completeResponseDictionary;
@property BOOL isAcknowledged;
@end
@interface CaptureAllArrayOfResponseObjecthandler : NSObject
/**
 *  to get values from the modal class call
 *
 *
 *
 *  @return object
 */

+(CaptureAllArrayOfResponse *)setModelObjectWithDictionary:(NSDictionary *)Dict;
/**
 *  set  values in the modal class using this method
 *
 *  @return object of modal class
 */


+(void)setModelObject:(CaptureAllArrayOfResponse *)obj;
+(CaptureAllArrayOfResponse *)getmainObj;

@end