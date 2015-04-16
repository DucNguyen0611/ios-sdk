//
//  CaptureDateRangeModalClass.m
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 19/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "CaptureDateRangeModalClass.h"

@implementation CaptureDateRangeModalClass

@end

static CaptureDateRangeModalClass *paymentObj;
@implementation CaptureDateRangeObjecthandler
/**
 *  initialise modal class object here
 */
+(void)initialize{
    paymentObj = [[CaptureDateRangeModalClass alloc]init];
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(void)setModelObject:(CaptureDateRangeModalClass *)obj{
    
    paymentObj=obj;
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(CaptureDateRangeModalClass *)getModelObject{
    
    return paymentObj;
}
@end
