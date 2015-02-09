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

+(void)initialize{
    responseOBj = [[VelocityResponse alloc]init];
}
+(VelocityResponse *)setModelObject:(id )obj{
    
    responseOBj=obj;
    return responseOBj;
}
+(VelocityResponse *)getModelObject{
    
    return responseOBj;
}



@end