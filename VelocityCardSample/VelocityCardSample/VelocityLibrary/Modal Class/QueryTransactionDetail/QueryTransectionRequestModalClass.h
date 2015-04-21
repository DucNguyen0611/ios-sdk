//
//  QueryTransectionRequestModalClass.h
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 27/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryTransectionRequestModalClass : NSObject
@property (strong,nonatomic) NSString * page;
@property (strong,nonatomic) NSString * pageSize;
@property (strong,nonatomic) NSString *captureEndDateTime;
@property (strong,nonatomic) NSString *captureStartDateTime;
@property (strong,nonatomic) NSString *transactionClass;
@property (strong,nonatomic) NSString *transactionType;
@property (strong,nonatomic) NSString *transactionEndDateTime;
@property (strong,nonatomic) NSString *transactionStartDateTime;
@property (strong,nonatomic) NSString *isAcknowledged;
@property (strong,nonatomic) NSString *includeRelated;
@property (strong,nonatomic) NSArray * amountArray;
@property (strong,nonatomic) NSArray * approvalCodes;
@property (strong,nonatomic) NSArray * batchIds;
@property (strong,nonatomic) NSArray * merchantProfileIds;
@property (strong,nonatomic) NSArray * orderNumbers;
@property (strong,nonatomic) NSArray * serviceIds;
@property (strong,nonatomic) NSArray * serviceKeys;
@property (strong,nonatomic) NSArray * transactionIds;
@end
@interface QueryTransectionRequestObjecthandler : NSObject
/**
 *  to get values from the modal class call
 *
 *
 *
 *  @return object
 */

+(QueryTransectionRequestModalClass *)getModelObject;
/**
 *  set  values in the modal class using this method
 *
 *  @return object of modal class
 */


+(void)setModelObject:(QueryTransectionRequestModalClass *)obj;


@end