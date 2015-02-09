//
//  AuthorizeTransaction.m
//  VelocityCardSample
//
//  Created by Chetu on 21/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "AuthorizeTransaction.h"

@implementation AuthorizeTransaction
@synthesize  applicationprofileId;
@synthesize merchantprofileId;

@end
static AuthorizeTransaction *authWObj;
@implementation AuthorizeTransactionObjecthandler
+(void)initialize{
    authWObj = [[AuthorizeTransaction alloc]init];
}
+(void)setModelObject:(AuthorizeTransaction *)obj{
    
    authWObj=obj;
}
+(AuthorizeTransaction *)getModelObject{
    
    return authWObj;
}
@end
