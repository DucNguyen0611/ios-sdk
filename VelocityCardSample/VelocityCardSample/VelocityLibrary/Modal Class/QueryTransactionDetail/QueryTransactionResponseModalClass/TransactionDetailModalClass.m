//
//  TransactionDetailModalClass.m
//  VelocityCardSample
//
//  Created by Amit Aman on 27/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "TransactionDetailModalClass.h"

@implementation TransactionDetailModalClass

@end

static TransactionDetailModalClass *transectionResponseObj;
@implementation TransactionDetailObjecthandler
/**
 *  initialise modal class object here
 */
+(void)initialize{
    transectionResponseObj = [[TransactionDetailModalClass alloc]init];
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(void)setModelObject:(TransactionDetailModalClass *)obj{
    
    transectionResponseObj = obj;
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(TransactionDetailModalClass *)getModelObject{
    
    return transectionResponseObj;
}
@end
