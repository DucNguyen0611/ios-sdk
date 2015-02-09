//
//  VelocityResponseModalClass.m
//  VelocityCardSample
//
//  Created by Chetu on 27/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "BankcardTransactionResponsePro.h"

@implementation BankcardTransactionResponsePro
//@synthesize status;
//@synthesize statusCode;
//@synthesize statusMessage;
//@synthesize transactionId;
//@synthesize originatorTransactionId;
//@synthesize serviceTransactionId;
////@synthesize serviceTransactionDateTime;
//@synthesize captureState;
//@synthesize transactionState;
//@synthesize acknowledged;
//@synthesize prepaidCard;
//@synthesize reference;
//@synthesize amount;
//@synthesize cardType;
//@synthesize feeAmount;
//@synthesize approvalCode;
//@synthesize aVSResult;
//@synthesize batchId;
//@synthesize cVResult;
//@synthesize cardLevel;
//@synthesize downgradeCode;
//@synthesize maskedPAN;
//@synthesize paymentAccountDataToken ;
//@synthesize retrievalReferenceNumber;
//@synthesize adviceResponse;
//@synthesize commercialCardResponse;
//@synthesize returnedACI;
//@synthesize statusHttpResponse;
//@synthesize statusCodeHttpResponse;
//@synthesize orderId;
//@synthesize settlementDate;
//@synthesize finalBalance;
//@synthesize cashBackAmount;
//- (id)initWithResponseDict:(NSDictionary *)dict {
//    if (self = [super init]) {
//       
//    }
//    return self;
//}

@end
@implementation  ServiceTransactionDateTime
@synthesize  date;
@synthesize time;
@synthesize timeZone;

@end

static BankcardTransactionResponsePro *responseObj;
@implementation ResponseObjecthandler
+(void)initialize{
    responseObj = [[BankcardTransactionResponsePro alloc]init];
}
+(BankcardTransactionResponsePro *)getModelObject{
    
    return responseObj;
    
}
+(BankcardTransactionResponsePro *)getModelObjectWithDic:(NSDictionary*)dict{
    responseObj.status = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"Status"];
    responseObj.statusCode = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"StatusCode"];
    responseObj.statusMessage = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"StatusMessage"];
    responseObj.transactionId = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"TransactionId"];
    responseObj.originatorTransactionId = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"OriginatorTransactionId"];
    responseObj.serviceTransactionId = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"ServiceTransactionId"];
    ServiceTransactionDateTime *serviceTransactionDateTime = [[ServiceTransactionDateTime alloc]init];
    serviceTransactionDateTime.date  = [[[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"ServiceTransactionDateTime"] objectForKey:@"Date"];
    serviceTransactionDateTime.time  = [[[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"ServiceTransactionDateTime"] objectForKey:@"Time"] ;
    serviceTransactionDateTime.timeZone  = [[[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"ServiceTransactionDateTime"] objectForKey:@"TimeZone"] ;
    responseObj.captureState = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"CaptureState"];
    responseObj.transactionState = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"TransactionState"];
    responseObj.acknowledged = (BOOL)[[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"IsAcknowledged"];
    responseObj.prepaidCard = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"PrepaidCard"];
    
    // reference = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"PrepaidCard"];
    responseObj.amount = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"Amount"];
    responseObj.cardType = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"CardType"];
    responseObj.feeAmount = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"FeeAmount"];
    responseObj.approvalCode = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"ApprovalCode"];
    // aVSResult = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"PrepaidCard"];
    responseObj.batchId = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"BatchId"];
    responseObj.cVResult = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"CVResult"];
    responseObj.cardLevel = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"CardLevel"];
    responseObj.downgradeCode = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"DowngradeCode"];
    responseObj.maskedPAN = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"MaskedPAN"];
    
    responseObj.paymentAccountDataToken = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"PaymentAccountDataToken"] ;
    responseObj.retrievalReferenceNumber = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"RetrievalReferenceNumber"];
    responseObj.adviceResponse = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"AdviceResponse"];
    responseObj.commercialCardResponse = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"CommercialCardResponse"];
    responseObj.returnedACI = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"ReturnedACI"];
    //  statusHttpResponse = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"MaskedPAN"];
    //  statusCodeHttpResponse = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"MaskedPAN"];
    responseObj.orderId = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"OrderId"];
    responseObj.settlementDate = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"SettlementDate"];
    responseObj.finalBalance = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"FinalBalance"];
    responseObj.cashBackAmount = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"CashBackAmount"];
    return responseObj;
}
+(BankcardTransactionResponsePro *)getmainObj{
    return responseObj;
}
@end
