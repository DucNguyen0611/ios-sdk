//
//  VelocityPaymentTransaction.h
//  VelocityCardSample
//
//  Created by Chetu on 22/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PaymentObjecthandler;
@interface VelocityPaymentTransaction : NSObject
@property (strong,nonatomic) NSString *transactionName;
@property (strong,nonatomic) NSString *state;
@property (strong,nonatomic) NSString *country;
@property (strong,nonatomic) NSString *amountforadjust;
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) NSString *cardType;
@property (strong,nonatomic) NSString *cardholderName;
@property (strong,nonatomic) NSString *panNumber;
@property (strong,nonatomic) NSString *expiryDate;
@property BOOL isNullable;
@property (strong,nonatomic) NSString *street;
@property (strong,nonatomic) NSString *city;
@property (strong,nonatomic) NSString *stateProvince;
@property (strong,nonatomic) NSString *postalCode;
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *cvDataProvided;
@property (strong,nonatomic) NSString *cVData;
@property (strong,nonatomic) NSString *amount;
@property (strong,nonatomic) NSString *currencyCode;
@property (strong,nonatomic) NSString *customerPresent;
@property (strong,nonatomic) NSString *employeeId;
@property (strong,nonatomic) NSString *entryMode;
@property (strong,nonatomic) NSString *industryType;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *countryCode;
@property (strong,nonatomic) NSString *businnessName;
@property (strong,nonatomic) NSString *CustomerId;
@property (strong,nonatomic) NSString *comment;
@property (strong,nonatomic) NSString *discription;
@property (strong,nonatomic) NSString *reportingDataReference;
@property (strong,nonatomic) NSString *transactionDataReference;
@property (strong,nonatomic) NSString *paymentAccountDataToken;
@property (strong,nonatomic) NSString *transactionDateTime;
@property (strong,nonatomic) NSString *cashBackAmount;
@property (strong,nonatomic) NSString *goodsType;
@property (strong,nonatomic) NSString *invoiceNumber;
@property (strong,nonatomic) NSString *orderNumber;
@property (strong,nonatomic) NSString *FeeAmount;
@property (strong,nonatomic) NSString *tipAmount;
@property (strong,nonatomic) NSString *accountType;

@end


@interface PaymentObjecthandler : NSObject
+(VelocityPaymentTransaction *)getModelObject;
+(void)setModelObject:(VelocityPaymentTransaction *)obj;


@end
