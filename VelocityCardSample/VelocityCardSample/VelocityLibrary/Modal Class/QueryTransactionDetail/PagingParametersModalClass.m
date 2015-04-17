//
//  PagingParametersModalClass.m
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 19/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "PagingParametersModalClass.h"

@implementation PagingParametersModalClass

@end
static PagingParametersModalClass *paymentObj;
@implementation PagingParametersObjecthandler
/**
 *  initialise modal class object here
 */
+(void)initialize{
    paymentObj = [[PagingParametersModalClass alloc]init];
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(void)setModelObject:(PagingParametersModalClass *)obj{
    
    paymentObj=obj;
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(PagingParametersModalClass *)getModelObject{
    
    return paymentObj;
}
@end
