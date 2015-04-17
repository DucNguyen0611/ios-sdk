//
//  CaptureAllArrayOfResponse.m
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 31/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "CaptureAllArrayOfResponse.h"

@implementation CaptureAllArrayOfResponse


@end

static CaptureAllArrayOfResponse *captureAllArrayObject;
@implementation CaptureAllArrayOfResponseObjecthandler
/**
 *  initialise modal class object here
 */
+(void)initialize{
    captureAllArrayObject = [[CaptureAllArrayOfResponse alloc]init];
}
/**
 *  For setting values in modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(void)setModelObject:(CaptureAllArrayOfResponse *)obj{
    
    captureAllArrayObject=obj;
}
/**
 *  For getting values from modal class
 *
 *  @param  class
 *
 *  @return object
 */
+(CaptureAllArrayOfResponse *)setModelObjectWithDictionary:(NSDictionary*)Dict{
    captureAllArrayObject.status = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"Status"];
    captureAllArrayObject.statusCode = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"StatusCode"];
    captureAllArrayObject.statusMessage = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"StatusMessage"];
    captureAllArrayObject.transactionId = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"TransactionId"];
    captureAllArrayObject.originatorTransactionId = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"OriginatorTransactionId"];
    captureAllArrayObject.serviceTransactionId = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"ServiceTransactionId"];
    captureAllArrayObject.serviceTransactionDateTime = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"ServiceTransactionDateTime"];
    captureAllArrayObject.addendum = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"Addendum"];
    captureAllArrayObject.captureState = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"CaptureState"];
    captureAllArrayObject.transactionState = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"TransactionState"];
    captureAllArrayObject.reference = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"Reference"];
    captureAllArrayObject.batchId = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"a:BatchId"];
    captureAllArrayObject.industryType = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"a:IndustryType"];
    captureAllArrayObject.PrepaidCard = [[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"a:PrepaidCard"];
    captureAllArrayObject.cashBackTotals = [[[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"a:TransactionSummaryData"] objectForKey:@"a:CashBackTotals"];
    captureAllArrayObject.netTotals = [[[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"a:TransactionSummaryData"] objectForKey:@"a:NetTotals"];
    captureAllArrayObject.pINDebitReturnTotals = [[[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"a:TransactionSummaryData"] objectForKey:@"a:PINDebitReturnTotals"];
    captureAllArrayObject.pINDebitSaleTotals = [[[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"a:TransactionSummaryData"] objectForKey:@"a:PINDebitReturnTotals"];
    captureAllArrayObject.returnTotals = [[[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"a:TransactionSummaryData"] objectForKey:@"a:PINDebitReturnTotals"];
    captureAllArrayObject.saleTotals = [[[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"a:TransactionSummaryData"] objectForKey:@"a:PINDebitSaleTotals"];
    captureAllArrayObject.voidTotals = [[[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"a:TransactionSummaryData"] objectForKey:@"a:VoidTotals"];
    captureAllArrayObject.isAcknowledged = [[[[Dict objectForKey:@"ArrayOfResponse"] objectForKey:@"Response"]objectForKey:@"IsAcknowledged"] boolValue];
    captureAllArrayObject.completeResponseDictionary = Dict;
    return captureAllArrayObject;
}
+(CaptureAllArrayOfResponse *)getmainObj{
    return captureAllArrayObject;
}
@end
