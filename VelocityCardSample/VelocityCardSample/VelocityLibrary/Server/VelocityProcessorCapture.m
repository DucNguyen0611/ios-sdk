//
//  VelocityProcessorCapture.m
//  VelocityCardSample
//
//  Created by Chetu on 09/02/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "VelocityProcessorCapture.h"
#import "VelocityPaymentTransaction.h"
#import "VelocityProcessorConstant.h"
#import "XMLReader.h"
#import "ErrorPaymentResponse.h"
#import "BankcardTransactionResponsePro.h"
#import "BancardCaptureResponse.h"
#import "Reachability.h"
@implementation VelocityProcessorCapture{
    ErrorPaymentResponse *errObj;
    BankcardTransactionResponsePro *banCardObj;
    VelocityPaymentTransaction *PaymentObj;
    BancardCaptureResponse *captureObj;
}
/**
 *  Check network status
 *
 *  @return true if connected
 */
-(BOOL)CheckNetworConnectivity
{
    BOOL isNetworkActive;
    
    
    NetworkStatus reach = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    
    //    isNetworkActive=NO;
    
    switch (reach) {
            
        case NotReachable:
            isNetworkActive=NO;
            break;
            
        case ReachableViaWiFi:
            isNetworkActive=YES;
            break;
            
        case ReachableViaWWAN:
            isNetworkActive=YES;
            break;
            
        default:
            isNetworkActive=NO;
            break;
    }
    
    return isNetworkActive;
}
/**
 *  Call service for capture method
 *
 *  @param appProfileID
 *  @param merchantID
 *  @param workDFlowID
 *  @param sessionToken
 *  @param isTestAccount 
 */
-(void)captureAndAppprofileid:(NSString *)appProfileID andMerchentID:(NSString *)merchantID andWorkFlowID:(NSString *)workDFlowID andSessionToken:(NSString *)sessionToken andIsTestAccount:(BOOL)isTestAccount{
    if ([self CheckNetworConnectivity ]== YES) {
    NSString *newStr = [sessionToken substringWithRange:NSMakeRange(1, [sessionToken length] - 2)];
    NSString *appendedString=[newStr stringByAppendingString:@" : "];
    NSData *tokenData = [appendedString dataUsingEncoding:NSUTF8StringEncoding];
    NSString * stringBase64 = [tokenData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
        PaymentObj =[PaymentObjecthandler getModelObject];
        
        NSString *xmlMainString =kHeadr_Xml;
     xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"\n<ChangeTransaction xmlns=\"%@/Rest\"\n",kXml_Base_Url]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"xmlns:i=\"%@\" i:type=\"Capture\">\n",kW3Org_url]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ApplicationProfileId>%@</ApplicationProfileId>\n",appProfileID]];

    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<DifferenceData xmlns:d2p1=\"%@\"\n",kXml_Base_Url]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"xmlns:d2p2=\"%@/Bankcard\"\n",kXml_Base_Url]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"xmlns:d2p3=\"http://schemas.ipcommerce.com/CWS/v2.0/TransactionProcessing\"\n"]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"i:type=\"d2p2:BankcardCapture\">\n"]];
    //this field transection id is assigned in verify method server request
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<d2p1:TransactionId>%@</d2p1:TransactionId>\n",PaymentObj.transectionID]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<d2p2:Amount>%@</d2p2:Amount>\n",PaymentObj.amount]];
    
    xmlMainString =[xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<d2p2:TipAmount>%@</d2p2:TipAmount>\n",PaymentObj.tipAmount]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</DifferenceData>\n"]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ChangeTransaction>\n"]];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url;
    if (isTestAccount)
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Txn/%@/%@",kServer_Test_Url,workDFlowID,PaymentObj.transectionID]];
    
    else
        url= [NSURL URLWithString:[NSString stringWithFormat:@"%@Txn/%@/%@",kServer_Url,workDFlowID,PaymentObj.transectionID]];
        
    NSMutableURLRequest *urlReq = [[NSMutableURLRequest alloc]initWithURL:url];
    [urlReq setTimeoutInterval:30];
    [urlReq setHTTPBody:[xmlMainString dataUsingEncoding:NSUTF8StringEncoding]];
    [urlReq setHTTPMethod:NSLocalizedString(@"PUT", nil)];
    [urlReq addValue:NSLocalizedString(@"application/xml",nil) forHTTPHeaderField:NSLocalizedString(@"Accept",nil)];
    [urlReq setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
    [urlReq setValue:[NSString stringWithFormat:@"Basics %@",stringBase64] forHTTPHeaderField:kAuthorization];
      NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlReq
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      
                                      {
                                          
                                          
                                          NSString *theXML = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                          NSString*httpCode= [NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
                                          NSDictionary * dict = [NSDictionary dictionaryWithDictionary:[XMLReader dictionaryForXMLString:theXML error:nil]];
                                          NSArray *dictNameArray =[dict allKeys];
                                          
                                          /**
                                           *  parsing response
                                           */
                                          if(error==nil && theXML.length>0){
                                              
                                              
                                              if(self.delegate != nil && ([self.delegate conformsToProtocol:@protocol(VelocityProcessorAuthWTokenDelegate)])){
                                                  if ([dictNameArray containsObject:kErrorResponse ]) {
                                                      
                                                      errObj =[ErrorObjecthandler getModelObjectWithDic:dict];
                                                      errObj.statusCodeHttpResponse = httpCode;
                                                      NSLog(@"error objects ****%@",errObj);
                                                      [self.delegate performSelector:@selector(VelocityProcessorCaptureServerRequestFailedWithErrorMessage:) withObject:errObj];
                                                  }
                                                  else{
                                                      captureObj=[BancardCaptureObjecthandler setModelObjectWithDic:dict];
                                                      captureObj.httpCode =httpCode;
                                                      
                                                      NSLog(@"bancard objects ****%@",banCardObj);
                                                      [self.delegate performSelector:@selector(VelocityProcessorCaptureServerRequestFinishedWithSuccess:) withObject:banCardObj];
                                                  }
                                                  
                                                  
                                                  
                                              }
                                              
                                          }
                                          else{
                                              
                                              [self.delegate performSelector:@selector(VelocityProcessorCaptureServerRequestFailedWithErrorMessage:) withObject:error];
                                              
                                              
                                          }
                                      }];
        
    [dataTask resume];
    }
    else{
        [self.delegate performSelector:@selector(VelocityProcessorCaptureServerRequestFailedWithErrorMessage:) withObject:@"Network Error!!"];
    }

}
//ssl request
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler{
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}

@end
