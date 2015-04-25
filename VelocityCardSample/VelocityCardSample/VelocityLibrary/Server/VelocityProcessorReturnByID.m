//
//  VelocityProcessorReturnByID.m
//  VelocityCardSample
//
//  Created by Chetu on 12/02/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "VelocityProcessorReturnByID.h"
#import "VelocityPaymentTransaction.h"
#import "VelocityProcessorConstant.h"
#import "XMLReader.h"
#import "ErrorPaymentResponse.h"
#import "BankcardTransactionResponsePro.h"
#import "BancardCaptureResponse.h"
#import "Reachability.h"
@implementation VelocityProcessorReturnByID{
    ErrorPaymentResponse *errObj;
    BankcardTransactionResponsePro *banCardObj;
    VelocityPaymentTransaction *PaymentObj;
    BancardCaptureResponse *captureObj;
}
/**
 *  check network status
 *
 *  @return Bool value
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
/**
 *  Call service for returnByID method
 *
 *  @param appProfileID
 *  @param merchantID
 *  @param workDFlowID
 *  @param sessionToken
 *  @param isTestAccount
 */
-(void)returnByIdAppprofileid:(NSString *)appProfileID andMerchentID:(NSString *)merchantID andWorkFlowID:(NSString *)workDFlowID andSessionToken:(NSString *)sessionToken andIsTestAccount:(BOOL)isTestAccount{
    if ([self CheckNetworConnectivity] == YES) {
    NSString *newStr = [sessionToken substringWithRange:NSMakeRange(1, [sessionToken length] - 2)];
    NSString *appendedString=[newStr stringByAppendingString:@" : "];
    NSData *tokenData = [appendedString dataUsingEncoding:NSUTF8StringEncoding];
    NSString * stringBase64 = [tokenData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    PaymentObj =[PaymentObjecthandler getModelObject];
    NSString *xmlMainString =kHeadr_Xml;
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"\n<ReturnById xmlns=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions/Rest\" xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" i:type=\"ReturnById\">\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ApplicationProfileId>%@</ApplicationProfileId>\n",appProfileID]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<BatchIds xmlns:d2p1=\"http://schemas.microsoft.com/2003/10/Serialization/Arrays\">%@</BatchIds>\n",PaymentObj.batchID]];
        xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<DifferenceData xmlns:ns1=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions/Bankcard\" i:type=\"ns1:BankcardReturn\">\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:TransactionId xmlns:ns2=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns2:TransactionId>\n",PaymentObj.transectionID]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:Amount >%@</ns1:Amount>\n",PaymentObj.amount]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</DifferenceData>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<MerchantProfileId>%@</MerchantProfileId>\n",merchantID]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ReturnById>\n"]];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url;
    if (isTestAccount)
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Txn/%@",kServer_Test_Url,workDFlowID]];
    
    else
        url= [NSURL URLWithString:[NSString stringWithFormat:@"%@Txn/%@",kServer_Url,workDFlowID]];
    NSMutableURLRequest *urlReq = [[NSMutableURLRequest alloc]initWithURL:url];
    [urlReq setTimeoutInterval:30];
    [urlReq setHTTPBody:[xmlMainString dataUsingEncoding:NSUTF8StringEncoding]];
    [urlReq setHTTPMethod:NSLocalizedString(@"POST", nil)];
    [urlReq addValue:NSLocalizedString(@"application/xml",nil) forHTTPHeaderField:NSLocalizedString(@"Accept",nil)];
    [urlReq setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
    [urlReq setValue:[NSString stringWithFormat:@"Basics %@",stringBase64] forHTTPHeaderField:kAuthorization];
        
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlReq
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      
                                      {
                                          
                                          
                                          NSString *theXML = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                          NSString*httpCode = [NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
                                          NSDictionary * dict = [NSDictionary dictionaryWithDictionary:[XMLReader dictionaryForXMLString:theXML error:nil]];
                                          NSArray *dictNameArray =[dict allKeys];
                                          
                                          /**
                                           *  Parsing response
                                           */
                                          if(error==nil && theXML.length>0){
                                              
                                              
                                              if(self.delegate != nil && ([self.delegate conformsToProtocol:@protocol(VelocityProcessorAuthWTokenDelegate)])){
                                                  if ([dictNameArray containsObject:kErrorResponse ]) {
                                                      
                                                      errObj =[ErrorObjecthandler getModelObjectWithDic:dict];
                                                      errObj.statusCodeHttpResponse = httpCode;
                                                      NSLog(@"error objects ****%@",errObj);
                                                      [self.delegate performSelector:@selector(VelocityProcessorReturnByIdServerRequestFailedWithErrorMessage:) withObject:errObj];
                                                  }
                                                  else{
                                                      banCardObj = [ResponseObjecthandler getModelObjectWithDic:dict];
                                                      banCardObj.statusCodeHttpResponse = httpCode;
                                                      
                                                      NSLog(@"bancard objects ****%@",banCardObj);
                                                      [self.delegate performSelector:@selector(VelocityProcessorReturnByIdServerRequestFinishedWithSuccess:) withObject:banCardObj];
                                                  }
                                                  
                                                  
                                                  
                                              }
                                              
                                          }
                                          else{
                                              
                                              [self.delegate performSelector:@selector(VelocityProcessorReturnByIdServerRequestFailedWithErrorMessage:) withObject:error];
                                              
                                              
                                          }
                                      }];
    
    
    [dataTask resume];
    
    }
    else{
        [self.delegate performSelector:@selector(VelocityProcessorReturnByIdServerRequestFailedWithErrorMessage:) withObject:@"Network Error!!"];
    }


}
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler{
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}
@end
