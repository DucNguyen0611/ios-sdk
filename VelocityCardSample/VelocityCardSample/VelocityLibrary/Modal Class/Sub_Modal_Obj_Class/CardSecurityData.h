//
//  CardSecurityData.h
//  VelocityCardSample
//
//  Created by Chetu on 21/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardSecurityData : NSObject
@property (strong,nonatomic) NSString *cvDataProvided;
@property (strong,nonatomic) NSString *cVData;
@property (strong,nonatomic) NSString *keySerialNumber;
@property (strong,nonatomic) NSString *pin;
@property (strong,nonatomic) NSString *identificationInformation;
@end
@interface CardSecurityDataObjecthandler : NSObject
+(CardSecurityData *)getModelObject;
+(void)setModelObject:(CardSecurityData *)obj;


@end