//
//  TransactionClassTypePairsModalClass.m
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 19/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "TransactionClassTypePairsModalClass.h"

@implementation TransactionClassTypePairsModalClass

@end
static TransactionClassTypePairsModalClass *paymentObj;

@implementation TransactionClassTypePairsObjecthandler
/**
 *  initialise modal class object here
 */
+(void)initialize{
    paymentObj = [[TransactionClassTypePairsModalClass alloc]init];
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(void)setModelObject:(TransactionClassTypePairsModalClass *)obj{
    
    paymentObj=obj;
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(TransactionClassTypePairsModalClass *)getModelObject{
    
    return paymentObj;
}
@end
