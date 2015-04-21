//
//  TransactionData.h
//  VelocityCardSample
//
//  Created by Chetu on 21/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionData : NSObject
@property (strong,nonatomic) NSString *amount;
@property (strong,nonatomic) NSString *currencyCode ;
@property (strong,nonatomic) NSString *transactiondateTime;
@property (strong,nonatomic) NSString *customerPresent;
@property (strong,nonatomic) NSString *employeeId;
@property (strong,nonatomic) NSString *entryMode;
@property (strong,nonatomic) NSString *industryType;
@property (strong,nonatomic) NSString *campingID;
@property (strong,nonatomic) NSString *reference;
@property (strong,nonatomic) NSString *accountType;
@property (strong,nonatomic) NSString *approvalCode;
@property (strong,nonatomic) NSString *cashBackMount;
@property (strong,nonatomic) NSString *goodsType;
@property (strong,nonatomic) NSString *internetTransData;
@property (strong,nonatomic) NSString *invoiceNo;
@property (strong,nonatomic) NSString *orderno;
@property BOOL isPartialShipment;
@property BOOL signatureCaptured;
@property (strong,nonatomic) NSString *feeAmount;
@property (strong,nonatomic) NSString *terminalId;
@property (strong,nonatomic) NSString *laneId;
@property (strong,nonatomic) NSString *tipAmount;
@property (strong,nonatomic) NSString *batchAssignment;
@property (strong,nonatomic) NSString *partialApprovalCapable;
@property (strong,nonatomic) NSString *scoreThreshold;
@property BOOL isQuashiCash;

@end

@interface TransactionDataObjecthandler : NSObject
+(TransactionData *)getModelObject;
+(void)setModelObject:(TransactionData *)obj;


@end