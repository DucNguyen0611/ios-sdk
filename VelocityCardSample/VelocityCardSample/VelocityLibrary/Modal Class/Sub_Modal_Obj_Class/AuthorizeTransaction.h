//
//  AuthorizeTransaction.h
//  VelocityCardSample
//
//  Created by Chetu on 21/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorizeTransaction : NSObject
@property (strong,nonatomic) NSString *applicationprofileId;
@property (strong,nonatomic) NSString *merchantprofileId;
//transaction;
@end
@interface AuthorizeTransactionObjecthandler : NSObject
+(AuthorizeTransaction *)getModelObject;
+(void)setModelObject:(AuthorizeTransaction *)obj;


@end