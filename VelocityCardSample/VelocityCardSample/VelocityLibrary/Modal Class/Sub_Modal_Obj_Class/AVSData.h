//
//  AVSData.h
//  VelocityCardSample
//
//  Created by Chetu on 21/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVSData : NSObject
//cardholderName;
@property (strong,nonatomic) NSString *street;
@property (strong,nonatomic) NSString *city;
@property (strong,nonatomic) NSString *stateProvince;
@property (strong,nonatomic) NSString *postalCode;
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *email;
@property BOOL isDataPresent;
@end
@interface AVSDataObjecthandler : NSObject
+(AVSData *)getModelObject;
+(void)setModelObject:(AVSData *)obj;


@end