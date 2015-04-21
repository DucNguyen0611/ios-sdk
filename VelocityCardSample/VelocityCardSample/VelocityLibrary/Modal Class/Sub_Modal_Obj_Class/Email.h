//
//  Email.h
//  VelocityCardSample
//
//  Created by Chetu on 21/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Email : NSObject
@property  BOOL nillable;
@property (strong,nonatomic) NSString *value;
@end
@interface EmailObjecthandler : NSObject
+(Email *)getModelObject;
+(void)setModelObject:(Email *)obj;


@end