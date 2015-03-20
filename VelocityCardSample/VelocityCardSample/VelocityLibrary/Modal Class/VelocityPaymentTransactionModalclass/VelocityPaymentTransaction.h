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
@property (strong,nonatomic) NSString *transectionID;
@property (strong,nonatomic) NSString *keySerialNumber;
@property (strong,nonatomic) NSString *identificationInformation;
@property (strong,nonatomic) NSString *ecommerceSecurityData;
@property (strong,nonatomic) NSString *track1Data;
@property (strong,nonatomic) NSString *street2;
@property (strong,nonatomic) NSString *fax;
@property (strong,nonatomic) NSString *customerTaxId;
@property (strong,nonatomic) NSString *shippingData;
@property (strong,nonatomic) NSString *securePaymentAccountData;
@property (strong,nonatomic) NSString *encryptionKeyId;
@property (strong,nonatomic) NSString *swipeStatus;
@property (strong,nonatomic) NSString *approvalCode;
@property (strong,nonatomic) NSString *internetTransactionData;
@property BOOL isPartialShipment;
@property BOOL isSignatureCaptured;
@property (strong,nonatomic) NSString *terminalID;
@property (strong,nonatomic) NSString *batchID;
@property (strong,nonatomic) NSString *partialApprovalCapable;
@property (strong,nonatomic) NSString *scoreThreshold;
@property BOOL isQuasiCash;
@property (strong,nonatomic) NSString *differenceData;
@end


@interface PaymentObjecthandler : NSObject
/**
 *  to get values from the modal class call
 *
 *
 *
 *  @return object
 */

+(VelocityPaymentTransaction *)getModelObject;
/**
 *  set  values in the modal class using this method
 *
 *  @return object of modal class
 */


+(void)setModelObject:(VelocityPaymentTransaction *)obj;


@end
