//
//  TransactionDateRangeModalClass.m
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 19/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "TransactionDateRangeModalClass.h"

@implementation TransactionDateRangeModalClass

@end
static TransactionDateRangeModalClass *paymentObj;

@implementation TransactionDateRangeObjecthandler
/**
 *  initialise modal class object here
 */
+(void)initialize{
    paymentObj = [[TransactionDateRangeModalClass alloc]init];
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(void)setModelObject:(TransactionDateRangeModalClass *)obj{
    
    paymentObj=obj;
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(TransactionDateRangeModalClass *)getModelObject{
    
    return paymentObj;
}
@end
