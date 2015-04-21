//
//  CaptureDateRangeModalClass.h
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 19/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaptureDateRangeModalClass : NSObject
@property (strong,nonatomic) NSString *endDateTime;
@property (strong,nonatomic) NSString *startDateTime;
@end
@interface CaptureDateRangeObjecthandler : NSObject
/**
 *  to get values from the modal class call
 *
 *
 *
 *  @return object
 */

+(CaptureDateRangeModalClass *)getModelObject;
/**
 *  set  values in the modal class using this method
 *
 *  @return object of modal class
 */


+(void)setModelObject:(CaptureDateRangeModalClass *)obj;


@end
