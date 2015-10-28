//
//  VelocityResponseModalClass.m
//  VelocityCardSample
//
//  Created by Chetu on 27/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//
/**
 *  this class is used to hold values Comming in the sucess response of requests
 */
#import "BankcardTransactionResponsePro.h"

@implementation BankcardTransactionResponsePro

@end
@implementation  ServiceTransactionDateTime
@synthesize  date;
@synthesize time;
@synthesize timeZone;

@end

static BankcardTransactionResponsePro *responseObj;
@implementation ResponseObjecthandler
/**
 *  initialise modal class object here
 */
+(void)initialize{
    responseObj = [[BankcardTransactionResponsePro alloc]init];
}

+(BankcardTransactionResponsePro *)getModelObject{
    
    return responseObj;
    
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */
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
	responseObj.emvData = [[dict objectForKey:@"BankcardTransactionResponsePro"] objectForKey:@"EMVData"];
    return responseObj;
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(BankcardTransactionResponsePro *)getmainObj{
    return responseObj;
}
@end
