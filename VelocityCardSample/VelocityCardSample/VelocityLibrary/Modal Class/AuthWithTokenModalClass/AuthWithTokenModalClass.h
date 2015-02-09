//
//  AuthWithTokenModalClass.h
//  VelocityCardSample
//
//  Created by Chetu on 02/02/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthWithTokenModalClass : NSObject
@property (strong,nonatomic) NSString *street1;
@property (strong,nonatomic) NSString *street2;
@property (strong,nonatomic) NSString *city;
@property (strong,nonatomic) NSString *stateProvince;
@property (strong,nonatomic) NSString *postalCode;
@property (strong,nonatomic) NSString *countryCode;
@property BOOL nillable;
@property (strong,nonatomic) NSString *value;
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *businessName;
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *fax;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *cardType;
@property (strong,nonatomic) NSString *pan;
@property (strong,nonatomic) NSString *expiryDate;
@property (strong,nonatomic) NSString *track1Data;
@property (strong,nonatomic) NSString *cVData;
@property (strong,nonatomic) NSString *cardHolderName;
@property (strong,nonatomic) NSString *billingData;
@property (strong,nonatomic) NSString *customerId;
@property (strong,nonatomic) NSString *shippingData;
@property (strong,nonatomic) NSString *customerTaxId;
@property (strong,nonatomic) NSString *comment;
@property (strong,nonatomic) NSString *discription;
@property (strong,nonatomic) NSString *reference;
@property (strong,nonatomic) NSString *paymentAccountDataToken;
@property (strong,nonatomic) NSString *paymentAccountDatawithoutToken;
@property (strong,nonatomic) NSString *securePaymentAccountData;
@property (strong,nonatomic) NSString *encryptionKeyId;
@property (strong,nonatomic) NSString *swipeStatus;
@property (strong,nonatomic) NSString *cardData;
@property (strong,nonatomic) NSString *ecommerceSecurityData;
@property (strong,nonatomic) NSString *customerData;
@property (strong,nonatomic) NSString *reportingData;
@property (strong,nonatomic) NSString *tenderData;
@property (strong,nonatomic) NSString *transactionData;
@property (strong,nonatomic) NSString *currencyCode;
@property (strong,nonatomic) NSString *transactionDateTime;
@property (strong,nonatomic) NSString *campaignId;

@property (strong,nonatomic) NSString *accountType;
@property (strong,nonatomic) NSString *approvalCode;
@property (strong,nonatomic) NSString *cashBackAmount;
@property (strong,nonatomic) NSString *customerPresent;
@property (strong,nonatomic) NSString *employeeId;
@property (strong,nonatomic) NSString *entryMode;
@property (strong,nonatomic) NSString *goodsType;
@property (strong,nonatomic) NSString *industryType;
@property (strong,nonatomic) NSString *internetTransactionData;
@property (strong,nonatomic) NSString *invoiceNumber;
@property (strong,nonatomic) NSString *orderNumber;
@property BOOL isPartialShipment;
@property BOOL signatureCaptured;
@property (strong,nonatomic) NSString *eeAmount;
@property (strong,nonatomic) NSString *terminalId;
@property (strong,nonatomic) NSString *laneId;
@property (strong,nonatomic) NSString *tipAmount;
@property (strong,nonatomic) NSString *batchAssignment;
@property (strong,nonatomic) NSString *partialApprovalCapable;
@property (strong,nonatomic) NSString *scoreThreshold;
@property BOOL isQuasiCash;
@end



@interface AuthWithObjecthandler : NSObject
+(void)setModelObject:(AuthWithTokenModalClass *)obj;
+(AuthWithTokenModalClass *)getModelObject;
@end