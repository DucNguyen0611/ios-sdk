//
//  ErrorPaymentResponse.h
//  VelocityCardSample
//
//  Created by Chetu on 29/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorPaymentResponse : NSObject
@property (strong,nonatomic) NSString *errorId;
@property (strong,nonatomic) NSString *helpUrl;
@property (strong,nonatomic) NSString *operation;
@property (strong,nonatomic) NSString *reason;
@property (strong,nonatomic) NSString *statusHttpResponse;
@property (strong,nonatomic) NSString *statusCodeHttpResponse;
@property (strong,nonatomic) NSString *ruleMessage;
@end

@interface ErrorObjecthandler : NSObject
+(ErrorPaymentResponse *)getModelObjectWithDic:(NSDictionary*)dict;
+(void)setModelObject:(ErrorPaymentResponse *)obj;
+(ErrorPaymentResponse *)getmainObj;
@end
