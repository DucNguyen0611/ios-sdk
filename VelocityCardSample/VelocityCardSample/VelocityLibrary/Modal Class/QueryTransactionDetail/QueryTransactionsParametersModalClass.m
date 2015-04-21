//
//  QueryTransactionsParametersModalClass.m
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 19/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "QueryTransactionsParametersModalClass.h"

@implementation QueryTransactionsParametersModalClass

@end
static QueryTransactionsParametersModalClass *paymentObj;

@implementation QueryTransactionsParametersObjecthandler
/**
 *  initialise modal class object here
 */
+(void)initialize{
    paymentObj = [[QueryTransactionsParametersModalClass alloc]init];
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(void)setModelObject:(QueryTransactionsParametersModalClass *)obj{
    
    paymentObj=obj;
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(QueryTransactionsParametersModalClass *)getModelObject{
    
    return paymentObj;
}
@end
