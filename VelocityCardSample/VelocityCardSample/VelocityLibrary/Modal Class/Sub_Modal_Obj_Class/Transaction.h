//
//  Transaction.h
//  VelocityCardSample
//
//  Created by Chetu on 21/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject
//TenderData tenderData;
//TransactionData transactionData;
@property (strong,nonatomic) NSString *type;
@end



@interface TransactionObjecthandler : NSObject
+(Transaction *)getModelObject;
+(void)setModelObject:(Transaction *)obj;


@end