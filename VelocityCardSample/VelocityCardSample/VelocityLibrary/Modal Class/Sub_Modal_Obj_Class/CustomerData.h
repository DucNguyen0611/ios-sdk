//
//  CustomerData.h
//  VelocityCardSample
//
//  Created by Chetu on 05/02/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerData : NSObject
@property (strong,nonatomic) NSString *customerId;
@property (strong,nonatomic) NSString *customerTaxId;
@property (strong,nonatomic) NSString *shipingData;
@end
@interface CustomerDataObjecthandler : NSObject
+(CustomerData *)getModelObject;
+(void)setModelObject:(CustomerData *)obj;


@end