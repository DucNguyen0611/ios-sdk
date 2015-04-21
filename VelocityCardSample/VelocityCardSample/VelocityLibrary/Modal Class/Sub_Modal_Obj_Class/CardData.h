//
//  CardData.h
//  VelocityCardSample
//
//  Created by Chetu on 21/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardData : NSObject
@property (strong,nonatomic) NSString *cardType;
@property (strong,nonatomic) NSString *cardholderName;
@property (strong,nonatomic) NSString *panNumber;
@property (strong,nonatomic) NSString *expiryDate;
//track1Data;
@end
@interface CardDataObjecthandler : NSObject
+(CardData *)getModelObject;
+(void)setModelObject:(CardData *)obj;


@end