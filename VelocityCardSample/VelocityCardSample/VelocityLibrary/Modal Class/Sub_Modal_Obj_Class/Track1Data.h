//
//  Track1Data.h
//  VelocityCardSample
//
//  Created by Chetu on 21/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track1Data : NSObject
@property  BOOL nillable;
@property (strong,nonatomic) NSString *value;

@end
@interface Track1DataObjecthandler : NSObject
+(Track1Data *)getModelObject;
+(void)setModelObject:(Track1Data *)obj;


@end