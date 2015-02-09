//
//  VelocityPaymentTransaction.m
//  VelocityCardSample
//
//  Created by Chetu on 22/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "VelocityPaymentTransaction.h"

@implementation VelocityPaymentTransaction
//@synthesize transactionName;
//@synthesize state;
//@synthesize country;
//@synthesize amountforadjust;
//@synthesize type;
//@synthesize cardType;
//@synthesize cardholderName;
//@synthesize panNumber;
//@synthesize expiryDate;
//@synthesize isNullable;
//@synthesize street;
//@synthesize city;
//@synthesize stateProvince;
//@synthesize postalCode;
//@synthesize phone;
//@synthesize cvDataProvided;
//@synthesize cVData;
//@synthesize amount;
//@synthesize currencyCode;
//@synthesize customerPresent;
//@synthesize employeeId;
//@synthesize entryMode;
//@synthesize industryType;
//@synthesize email;
//@synthesize countryCode;
//@synthesize businnessName;
//@synthesize CustomerId;
//@synthesize comment;
//@synthesize description;
//@synthesize reportingDataReference;
//@synthesize transactionDataReference;
//@synthesize paymentAccountDataToken;
//@synthesize transactionDateTime;
//@synthesize cashBackAmount;
//@synthesize goodsType;
//@synthesize invoiceNumber;
//@synthesize orderNumber;
//@synthesize FeeAmount;
//@synthesize tipAmount;
//
//- (id)init{
//    self=[super init];
//    return self;
//}


@end

static VelocityPaymentTransaction *paymentObj;
@implementation PaymentObjecthandler
+(void)initialize{
    paymentObj = [[VelocityPaymentTransaction alloc]init];
}
+(void)setModelObject:(VelocityPaymentTransaction *)obj{
    
    paymentObj=obj;
}
+(VelocityPaymentTransaction *)getModelObject{

    return paymentObj;
}
@end

