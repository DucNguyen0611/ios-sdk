
//  ErrorPaymentResponse.m
//  VelocityCardSample
//
//  Created by Chetu on 29/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//
/**
 *  this class holds the values comming  in error response
 */
#import "ErrorPaymentResponse.h"

@implementation ErrorPaymentResponse

@end

static ErrorPaymentResponse *errResponseObj;
@implementation ErrorObjecthandler
/**
 *  initialise modal class object here
 */
+(void)initialize{
    errResponseObj = [[ErrorPaymentResponse alloc]init];
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(void)setModelObject:(ErrorPaymentResponse *)obj{
    errResponseObj = obj;
    
    
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(ErrorPaymentResponse *)getModelObjectWithDic:(NSDictionary *)dict{

    if ([[dict objectForKey:@"ErrorResponse"] objectForKey:@"ErrorId"]==nil) {
       
        errResponseObj.helpUrl = [dict objectForKey:@"HelpUrl"];
        errResponseObj.operation = [dict objectForKey:@"Operation"];
        errResponseObj.reason = [dict objectForKey:@"Reason"];
        errResponseObj.ruleMessage = [[dict objectForKey:@"Messages"] objectAtIndex:0];
         errResponseObj.errorId = [dict valueForKey:@"ErrorId"];
    }
    else{
    errResponseObj.errorId = [[dict objectForKey:@"ErrorResponse"] objectForKey:@"ErrorId"];
    
    errResponseObj.helpUrl = [[dict objectForKey:@"ErrorResponse"] objectForKey:@"HelpUrl"];
    errResponseObj.operation = [[dict objectForKey:@"ErrorResponse"] objectForKey:@"Operation"];
    errResponseObj.reason = [[dict objectForKey:@"ErrorResponse"] objectForKey:@"Reason"];
//    errResponseObj.statusHttpResponse = [[dict objectForKey:@"ErrorResponse"] objectForKey:@"ErrorId"];
//    errResponseObj.statusCodeHttpResponse = [[dict objectForKey:@"ErrorResponse"] objectForKey:@"ErrorId"];
    
    if ([[[[dict objectForKey:@"ErrorResponse"] objectForKey:@"ValidationErrors"] objectForKey:@"ValidationError"] isKindOfClass:[NSArray class]]) {
        errResponseObj.ruleMessage = [[[[[dict objectForKey:@"ErrorResponse"] objectForKey:@"ValidationErrors"] objectForKey:@"ValidationError"] objectAtIndex:0]objectForKey:@"RuleMessage"];
    }
    else
        errResponseObj.ruleMessage = [[[[dict objectForKey:@"ErrorResponse"] objectForKey:@"ValidationErrors"] objectForKey:@"ValidationError"]objectForKey:@"RuleMessage"];
    }
    return errResponseObj;
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(ErrorPaymentResponse *)getmainObj{
    return errResponseObj;
}
@end