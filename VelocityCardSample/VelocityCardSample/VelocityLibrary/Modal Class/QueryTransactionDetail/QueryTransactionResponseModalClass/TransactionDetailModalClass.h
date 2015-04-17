//
//  TransactionDetailModalClass.h
//  VelocityCardSample
//
//  Created by Amit Aman on 27/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionDetailModalClass : NSObject
@property (strong,nonatomic) NSArray * transactionDetailArray;
@end


@interface TransactionDetailObjecthandler : NSObject
/**
 *  to get values from the modal class call
 *
 *
 *
 *  @return object
 */

+(TransactionDetailModalClass *)getModelObject;
/**
 *  set  values in the modal class using this method
 *
 *  @return object of modal class
 */


+(void)setModelObject:(TransactionDetailModalClass *)obj;


@end