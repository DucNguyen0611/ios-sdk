//
//  QueryTransactionsParametersModalClass.h
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 19/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryTransactionsParametersModalClass : NSObject
@property (strong,nonatomic) NSArray * amountArr;
@property (strong,nonatomic) NSArray * approvalCodes;
@property (strong,nonatomic) NSArray * batchIds;
@property (strong,nonatomic) NSArray * merchantProfileIds;
@property (strong,nonatomic) NSArray * orderNumbers;
@property (strong,nonatomic) NSArray * serviceIds;
@property (strong,nonatomic) NSArray * serviceKeys;
@property (strong,nonatomic) NSArray * transactionIds;
@end
@interface QueryTransactionsParametersObjecthandler : NSObject
/**
 *  to get values from the modal class call
 *
 *
 *
 *  @return object
 */

+(QueryTransactionsParametersModalClass *)getModelObject;
/**
 *  set  values in the modal class using this method
 *
 *  @return object of modal class
 */


+(void)setModelObject:(QueryTransactionsParametersModalClass *)obj;


@end
