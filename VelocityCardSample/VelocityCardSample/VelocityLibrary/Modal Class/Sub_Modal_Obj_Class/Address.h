//
//  Address.h
//  VelocityCardSample
//
//  Created by Chetu on 05/02/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject
@property (strong,nonatomic) NSString *Street1;
@property (strong,nonatomic) NSString *Street2;
@property (strong,nonatomic) NSString *City;
@property (strong,nonatomic) NSString *StateProvince;
@property (strong,nonatomic) NSString *PostalCode;
@property (strong,nonatomic) NSString *CountryCode;
@end
@interface AddressObjecthandler : NSObject
+(Address *)getModelObject;
+(void)setModelObject:(Address *)obj;


@end