//
//  BillingData.h
//  VelocityCardSample
//
//  Created by Chetu on 05/02/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillingData : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *businessName;
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *fax;
@property (strong,nonatomic) NSString *email;

@end
@interface BillingDataObjecthandler : NSObject
+(BillingData *)getModelObject;
+(void)setModelObject:(BillingData *)obj;


@end