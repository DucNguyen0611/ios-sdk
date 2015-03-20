//
//  VelocityPaymentTransaction.m
//  VelocityCardSample
//
//  Created by Chetu on 22/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//
/**
 *  this class used for setting values in the XML request.It olds the values from user
 */
#import "VelocityPaymentTransaction.h"

@implementation VelocityPaymentTransaction

@end

static VelocityPaymentTransaction *paymentObj;
@implementation PaymentObjecthandler
/**
 *  initialise modal class object here
 */
+(void)initialize{
    paymentObj = [[VelocityPaymentTransaction alloc]init];
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(void)setModelObject:(VelocityPaymentTransaction *)obj{
    
    paymentObj=obj;
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(VelocityPaymentTransaction *)getModelObject{

    return paymentObj;
}
@end

