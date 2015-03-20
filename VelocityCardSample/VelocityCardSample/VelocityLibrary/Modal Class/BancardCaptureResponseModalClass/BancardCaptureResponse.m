//
//  BancardCaptureResponse.m
//  VelocityCardSample
//
//  Created by Chetu on 10/02/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//
/**
 *  this class holds the response form Capture request
 */
#import "BancardCaptureResponse.h"

@implementation BancardCaptureResponse

@end


static BancardCaptureResponse *captureObj;

@implementation BancardCaptureObjecthandler
/**
 *  initialise modal class object here
 */

+(void)initialize{
    captureObj = [[BancardCaptureResponse alloc]init];
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */

+(void)setModelObject:(BancardCaptureResponse *)obj{
    
    captureObj=obj;
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */

+(BancardCaptureResponse *)getModelObject{
    
    return captureObj;
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */

+(BancardCaptureResponse *)setModelObjectWithDic:(NSDictionary*)dict{
    captureObj.status =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"Status"];
    captureObj.statusCode =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"StatusCode"];
    captureObj.statusMessage =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"StatusMessage"];
    captureObj.transactionId =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"TransactionId"];
    captureObj.originatorTransactionId =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"OriginatorTransactionId"];
    captureObj.serviceTransactionId =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"ServiceTransactionId"];
    //captureObj.serviceTransactionDateTime =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"StatusCode"];
    captureObj.captureState =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"CaptureState"];
    captureObj.transactionState =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"TransactionState"];
    captureObj.isacknowledged =(BOOL)[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"IsAcknowledged"];
    captureObj.prepaidCard =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"PrepaidCard"];
    captureObj.reference =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"Reference"];
    captureObj.netAmount =[[[[dict objectForKey:@"BankcardCaptureResponse"]  objectForKey:@"TransactionSummaryData"]objectForKey:@"NetTotals"]objectForKey:@"NetAmount"];
    captureObj.cardType =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"PrepaidCard"];
   // captureObj.approvalCode =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"StatusCode"];
    captureObj.batchId =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"BatchId"];
    captureObj.industryType =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"IndustryType"];
    //captureObj.cVResult =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"StatusCode"];
    //captureObj.paymentAccountDataToken =[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"StatusCode"];
    captureObj.count =[[[[dict objectForKey:@"BankcardCaptureResponse"]  objectForKey:@"TransactionSummaryData"]objectForKey:@"NetTotals"] objectForKey:@"Count"];
    captureObj.date =[[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"ServiceTransactionDateTime"]objectForKey:@"Date"];
    captureObj.time =[[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"ServiceTransactionDateTime"]objectForKey:@"Time"];
    captureObj.timeZone =[[[dict objectForKey:@"BankcardCaptureResponse"] objectForKey:@"ServiceTransactionDateTime"]objectForKey:@"TimeZone"];
    
    return captureObj;
}
+(BancardCaptureResponse *)getmainObj{
    return captureObj;
}

@end
