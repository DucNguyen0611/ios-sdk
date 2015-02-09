
//  ErrorPaymentResponse.m
//  VelocityCardSample
//
//  Created by Chetu on 29/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "ErrorPaymentResponse.h"

@implementation ErrorPaymentResponse

@end

static ErrorPaymentResponse *errResponseObj;
@implementation ErrorObjecthandler
+(void)initialize{
    errResponseObj = [[ErrorPaymentResponse alloc]init];
}
+(void)setModelObject:(ErrorPaymentResponse *)obj{
    errResponseObj=obj;
    
    
}
+(ErrorPaymentResponse *)getModelObjectWithDic:(NSDictionary *)dict{

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
    
    return errResponseObj;
}

+(ErrorPaymentResponse *)getmainObj{
    return errResponseObj;
}
@end