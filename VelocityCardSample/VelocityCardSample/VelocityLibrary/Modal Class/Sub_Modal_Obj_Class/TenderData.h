//
//  TenderData.h
//  VelocityCardSample
//
//  Created by Chetu on 21/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TenderData : NSObject
@property (strong,nonatomic) NSString *paymentAccountDataToken;
@property (strong,nonatomic) NSString *securePaymentAccountData;
@property (strong,nonatomic) NSString *encriptionKeyId;
@property (strong,nonatomic) NSString *swipeStatus;
@property (strong,nonatomic) NSString *ecommerceSecurityData;


@end
@interface TenderDataObjecthandler : NSObject
+(TenderData *)getModelObject;
+(void)setModelObject:(TenderData *)obj;


@end