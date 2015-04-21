//
//  VelocityResponse.m
//  VelocityCardSample
//
//  Created by Chetu on 30/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "VelocityResponse.h"

@implementation VelocityResponse

@end
static VelocityResponse *responseOBj;
@implementation VelocityResponseObjectHandlers
/**
 *  initialise modal class object here
 */
+(void)initialize{
    responseOBj = [[VelocityResponse alloc]init];
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(VelocityResponse *)setModelObject:(id )obj{
    
    responseOBj = obj;
    return responseOBj;
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(VelocityResponse *)getModelObject{
    
    return responseOBj;
}



@end