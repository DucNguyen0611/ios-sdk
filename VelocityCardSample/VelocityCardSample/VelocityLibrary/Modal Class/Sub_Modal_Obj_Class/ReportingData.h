//
//  ReportingData.h
//  VelocityCardSample
//
//  Created by Chetu on 05/02/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportingData : NSObject
@property (strong,nonatomic) NSString *comment;
@property (strong,nonatomic) NSString *discription;
@property (strong,nonatomic) NSString *reference;
@end
@interface ReportingDataObjecthandler : NSObject
+(ReportingData *)getModelObject;
+(void)setModelObject:(ReportingData *)obj;


@end