//
//  QueryTransectionRequestModalClass.m
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 27/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "QueryTransectionRequestModalClass.h"

@implementation QueryTransectionRequestModalClass

@end
static QueryTransectionRequestModalClass *transectionRequestObj;
@implementation QueryTransectionRequestObjecthandler
/**
 *  initialise modal class object here
 */
+(void)initialize{
    transectionRequestObj = [[QueryTransectionRequestModalClass alloc]init];
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(void)setModelObject:(QueryTransectionRequestModalClass *)obj{
    
    transectionRequestObj = obj;
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(QueryTransectionRequestModalClass *)getModelObject{
    
    return transectionRequestObj;
}
@end
