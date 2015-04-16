//
//  PagingParametersModalClass.h
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 19/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PagingParametersModalClass : NSObject

@end

@interface PagingParametersObjecthandler : NSObject
/**
 *  to get values from the modal class call
 *
 *
 *
 *  @return object
 */

+(PagingParametersModalClass *)getModelObject;
/**
 *  set  values in the modal class using this method
 *
 *  @return object of modal class
 */


+(void)setModelObject:(PagingParametersModalClass *)obj;


@end

