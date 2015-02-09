//
//  AuthWithTokenModalClass.m
//  VelocityCardSample
//
//  Created by Chetu on 02/02/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "AuthWithTokenModalClass.h"

@implementation AuthWithTokenModalClass

@end

static AuthWithTokenModalClass *authWObj;
@implementation AuthWithObjecthandler
+(void)initialize{
    authWObj = [[AuthWithTokenModalClass alloc]init];
}
+(void)setModelObject:(AuthWithTokenModalClass *)obj{
    
    authWObj=obj;
}
+(AuthWithTokenModalClass *)getModelObject{
    
    return authWObj;
}
@end
