//
//  VelocityQueryTransactionDetails.m
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 19/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "VelocityQueryTransactionDetails.h"
#import "XMLReader.h"
#import "Reachability.h"
#import "VelocityProcessorConstant.h"
#import "ErrorPaymentResponse.h"
#import "TransactionDetailModalClass.h"
#import "QueryTransectionRequestModalClass.h"
@implementation VelocityQueryTransactionDetails{
    ErrorPaymentResponse *errObj;
    TransactionDetailModalClass *transactionDetailObject;
    QueryTransectionRequestModalClass *queryRequestObject;
}
/**
 *  check network connectivity
 *
 *  @return bool value
 */
-(BOOL)CheckNetworConnectivity
{
    BOOL isNetworkActive;
    
    
    NetworkStatus reach = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    
    //    isNetworkActive=NO;
    
    switch (reach) {
            
        case NotReachable:
            isNetworkActive = NO;
            break;
            
        case ReachableViaWiFi:
            isNetworkActive = YES;
            break;
            
        case ReachableViaWWAN:
            isNetworkActive = YES;
            break;
            
        default:
            isNetworkActive = NO;
            break;
    }
    
    return isNetworkActive;
}

-(void)queryTransactionDetailsAppprofileid:(NSString *)appProfileID andMerchentID:(NSString *)merchantID andWorkFlowID:(NSString *)workDFlowID andSessionToken:(NSString *)sessionToken andIsTestAccount:(BOOL)isTestAccount{
    if ([self CheckNetworConnectivity]==YES) {
        /**
         *  passing session token
         *
         *
         *  @return nsstring
         */
        NSString *newStr = [sessionToken substringWithRange:NSMakeRange(1, [sessionToken length] - 2)];
        NSString *appendedString=[newStr stringByAppendingString:@" : "];
        NSData *tokenData = [appendedString dataUsingEncoding:NSUTF8StringEncoding];
        NSString * stringBase64 = [tokenData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
        queryRequestObject = [[QueryTransectionRequestModalClass alloc]init];
        queryRequestObject = [QueryTransectionRequestObjecthandler getModelObject];
        /**
         *  JSON for requesting server
         */
        NSDictionary * transactionDateRange = [NSDictionary dictionaryWithObjectsAndKeys:
                                        queryRequestObject.transactionStartDateTime,@"startDateTime",
                                               queryRequestObject.transactionEndDateTime,@"endDateTime"
                                               , nil];
        
        NSDictionary * pagingParameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                           queryRequestObject.page , @"page",
                                           queryRequestObject.pageSize,@"pageSize"
                                           ,nil];
//        NSDictionary * CaptureDateRange = [NSDictionary dictionaryWithObjectsAndKeys:
//                                           queryRequestObject.captureStartDateTime,@"startDateTime",
//                                           queryRequestObject.captureEndDateTime,@"endDateTime"
//                                           ,nil];
        NSString *startDateTime =[transactionDateRange valueForKey:@"startDateTime"];
        NSString *endDateTime =[transactionDateRange valueForKey:@"endDateTime"];
//        NSDictionary * queryTransactionsParameters;
//        if (startDateTime.length==0 && endDateTime.length==0 ) {
//            queryTransactionsParameters = [[NSDictionary alloc]init];
//            queryTransactionsParameters = [NSDictionary dictionaryWithObjectsAndKeys:
//                                           //transactionDateRange ,@"transactionDateRange",
//                                           queryRequestObject.transactionIds, @"transactionIds",
//                                           queryRequestObject.amountArray,@"amount",
//                                           queryRequestObject.approvalCodes,@"approvalCode",
//                                           queryRequestObject.batchIds,@"batchId",
//                                           queryRequestObject.serviceIds,@"serviceId",
//                                           
//                                           queryRequestObject.isAcknowledged,@"isAcknowledged"
//                                           , nil];
//            
//        }
//        else{
//        queryTransactionsParameters = [[NSDictionary alloc]init];
//        queryTransactionsParameters = [NSDictionary dictionaryWithObjectsAndKeys:
//                                                      transactionDateRange ,@"transactionDateRange",
//                                                      queryRequestObject.transactionIds, @"transactionIds",
//                                                      queryRequestObject.amountArray,@"amount",
//                                                      queryRequestObject.approvalCodes,@"approvalCode",
//                                                      queryRequestObject.batchIds,@"batchId",
//                                                      queryRequestObject.serviceIds,@"serviceId",
//                                                      
//                                                queryRequestObject.isAcknowledged,@"isAcknowledged"
//                                                      , nil];
//        }
        NSMutableDictionary * queryTransactionsParameters = [[NSMutableDictionary alloc ]init];
                
        if ([[queryRequestObject.transactionIds objectAtIndex:0] isEqualToString:@""] && startDateTime.length==0 && endDateTime.length==0  &&![[queryRequestObject.batchIds objectAtIndex:0] isEqualToString:@""]) {
            
            [queryTransactionsParameters setValue:queryRequestObject.batchIds forKey:@"batchIds"];
            [queryTransactionsParameters setValue:queryRequestObject.isAcknowledged forKey:@"isAcknowledged"];
        }
       else if (![[queryRequestObject.transactionIds objectAtIndex:0] isEqualToString:@""] && startDateTime.length==0 && endDateTime.length==0  &&[[queryRequestObject.batchIds objectAtIndex:0] isEqualToString:@""]) {
            
            [queryTransactionsParameters setValue:queryRequestObject.transactionIds forKey:@"transactionIds"];
            [queryTransactionsParameters setValue:queryRequestObject.isAcknowledged forKey:@"isAcknowledged"];
        }
       else if ([[queryRequestObject.transactionIds objectAtIndex:0] isEqualToString:@""] && startDateTime.length!=0 && endDateTime.length!=0  &&[[queryRequestObject.batchIds objectAtIndex:0] isEqualToString:@""]) {
           
           [queryTransactionsParameters setValue:transactionDateRange forKey:@"transactionDateRange"];
           [queryTransactionsParameters setValue:queryRequestObject.isAcknowledged forKey:@"isAcknowledged"];
       }
       else if (![[queryRequestObject.transactionIds objectAtIndex:0] isEqualToString:@""] && startDateTime.length==0 && endDateTime.length==0  &&![[queryRequestObject.batchIds objectAtIndex:0] isEqualToString:@""]){
           [queryTransactionsParameters setValue:queryRequestObject.transactionIds forKey:@"transactionIds"];
         
           [queryTransactionsParameters setValue:queryRequestObject.isAcknowledged forKey:@"isAcknowledged"];
       }
    
        
        NSString *page = [pagingParameters valueForKey:@"page"];
        NSString *pageSize =[pagingParameters valueForKey:@"pageSize"];
        NSDictionary *jsonDictionary;
        
        if (page.length == 0  && pageSize.length == 0) {
            jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                            @"CWSTransaction", @"transactionDetailFormat",
                                            queryRequestObject.includeRelated ,@"includeRelated",
                                            queryTransactionsParameters , @"queryTransactionsParameters"
                                            
                                            , nil];

        }
        else{
        jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"CWSTransaction", @"transactionDetailFormat",
                                        queryRequestObject.includeRelated ,@"includeRelated",
                                        pagingParameters , @"pagingParameters",
                                        queryTransactionsParameters , @"queryTransactionsParameters"
                         
                                        
                                        , nil];
        }
        
        NSData* data = [ NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil ];
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     
        
        
              NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        NSURL *url;
        if (isTestAccount)
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/DataServices/TMS/transactionsDetail",kServer_Test_Url]];
        
        else
            url= [NSURL URLWithString:[NSString stringWithFormat:@"%@/DataServices/TMS/transactionsDetail",kServer_Url]];
        
        NSMutableURLRequest *urlReq = [[NSMutableURLRequest alloc]initWithURL:url];
        [urlReq setTimeoutInterval:30];
        [urlReq setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        [urlReq setHTTPMethod:NSLocalizedString(@"POST", nil)];
        [urlReq addValue:NSLocalizedString(@"application/json",nil) forHTTPHeaderField:NSLocalizedString(@"Accept",nil)];
        [urlReq setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
        [urlReq setValue:[NSString stringWithFormat:@"Basics %@",stringBase64] forHTTPHeaderField:kAuthorization];
        
        NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlReq
                                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          
                                          {
                                              
                                              
                                              NSString *theXML = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
                                              NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                              NSString*httpCode= [NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
                                              
                                              //NSDictionary * dict = [NSDictionary dictionaryWithDictionary:[XMLReader dictionaryForXMLString:theXML error:nil]];
                                              NSArray *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                              NSDictionary *dict2 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

                                             // NSArray *dictNameArray = [dict objectForKey:@"TransactionDetail"];
                                              
                                              /**
                                               *  Parsing Response
                                               */
                                              if(error==nil && theXML.length>0){
                                                  
                                                  
                                                  if(self.delegate != nil && ([self.delegate conformsToProtocol:@protocol(VelocityProcessorQueryTransactionDetailDelegate)])){
                                                      if ( [dict isKindOfClass:[NSDictionary class]]) {
                                                          
                                                          errObj =[ErrorObjecthandler getModelObjectWithDic:dict2];
                                                          errObj.statusCodeHttpResponse = httpCode;
                                                          NSLog(@"error objects ****%@",errObj);
                                  
                                                          
                                                          [self.delegate performSelector:@selector(VelocityProcessorQueryTransactionDetailServerRequestFailedWithErrorMessage:) withObject:errObj];
                                                      }
                                                      else{
                                                          transactionDetailObject =[[TransactionDetailModalClass alloc]init];
                                                      [TransactionDetailObjecthandler setModelObject:transactionDetailObject];
                                                         // [TransactionDetailObjecthandler getModelObject];
                                                          transactionDetailObject.transactionDetailArray = dict ;
                                                          
                                                        //  NSLog(@"bancard objects ****%@",dict);
                                                          [self.delegate performSelector:@selector(VelocityProcessorQueryTransactionDetailServerRequestFinishedWithSuccess:) withObject:transactionDetailObject];
                                                      }
                                                     
                                                      
                                                      
                                                  }
                                                  
                                              }
                                              else{
                                                  
                                                  [self.delegate performSelector:@selector(VelocityProcessorQueryTransactionDetailServerRequestFailedWithErrorMessage:) withObject:error];

                                                  
                                             }
                                          }];
        
        
        [dataTask resume];
  
    }
    else{
        [self.delegate performSelector:@selector(VelocityProcessorQueryTransactionDetailServerRequestFailedWithErrorMessage:) withObject:@"Network Error!!"];
    }
}
/**
 *  ssl verification
 *
 *  @param session
 *  @param challenge
 *  @param completionHandler
 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler{
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}
@end
