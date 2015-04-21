//
//  VelocityProcessorCaptureAll.m
//  VelocityCardSample
//
//  Created by Chetu-mac-Mini24 on 30/03/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "VelocityProcessorCaptureAll.h"
#import "VelocityPaymentTransaction.h"
#import "VelocityProcessorConstant.h"
#import "XMLReader.h"
#import "ErrorPaymentResponse.h"
#import "BankcardTransactionResponsePro.h"

#import "CaptureAllArrayOfResponse.h"
@implementation VelocityProcessorCaptureAll
{
    ErrorPaymentResponse *errObj;
    VelocityPaymentTransaction *PaymentObj;
    CaptureAllArrayOfResponse *captureAllArrayObj;

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

-(void)CaptureAllWithsAppprofileid:(NSString *)appProfileID andMerchentID:(NSString *)merchantID andWorkFlowID:(NSString *)workDFlowID andSessionToken:(NSString *)sessionToken andIsTestAccount:(BOOL)isTestAccount{
     if ([self CheckNetworConnectivity]==YES) {
         NSString *newStr = [sessionToken substringWithRange:NSMakeRange(1, [sessionToken length] - 2)];
         NSString *appendedString=[newStr stringByAppendingString:@" : "];
         NSData *tokenData = [appendedString dataUsingEncoding:NSUTF8StringEncoding];
         NSString * stringBase64 = [tokenData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
         PaymentObj =[PaymentObjecthandler getModelObject];
         
         NSString *xmlMainString =kHeadr_Xml;
         
          xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<CaptureAll xmlns=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions/Rest\" xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" i:type=\"CaptureAll\">\n"]];
          xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ApplicationProfileId>%@</ApplicationProfileId>\n",appProfileID]];
          xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@" <BatchIds xmlns:d2p1=\"http://schemas.microsoft.com/2003/10/Serialization/Arrays\" i:nil=\"true\" />\n"]];
          xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<DifferenceData xmlns:d2p1=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\" i:nil=\"true\" />\n"]];
          xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<MerchantProfileId>%@</MerchantProfileId>\n",merchantID]];
          xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"\n"]];
         //this field transection id is assigned in verify method server request
          xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</CaptureAll>\n"]];
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
                                                  
                                                   
                                                   if(self.delegate != nil && ([self.delegate conformsToProtocol:@protocol(VelocityProcessorCaptureAllDelegate)])){
                                                       if ([dictNameArray containsObject:kErrorResponse ]) {
                                                           
                                                           errObj =[ErrorObjecthandler getModelObjectWithDic:dict];
                                                           errObj.statusCodeHttpResponse = httpCode;
                                                           NSLog(@"error objects ****%@",errObj);
                                                           [self.delegate performSelector:@selector(VelocityProcessorCaptureAllServerRequestFailedWithErrorMessage:) withObject:errObj];
                                                       }
                                                       else{
                                                           captureAllArrayObj =[CaptureAllArrayOfResponseObjecthandler setModelObjectWithDictionary:dict];
                                                           captureAllArrayObj.httpCode = httpCode;
                                                           
                                                           NSLog(@"bancard objects ****%@",captureAllArrayObj);
                                                           [self.delegate performSelector:@selector(VelocityProcessorCaptureAllServerRequestFinishedWithSuccess:) withObject:captureAllArrayObj];
                                                       }
                                                       
                                                       
                                                       
                                                   }
                                                   
                                               }
                                               else{
                                                   
                                                   [self.delegate performSelector:@selector(VelocityProcessorCaptureAllServerRequestFailedWithErrorMessage:) withObject:error];
                                                   
                                                   
                                               }
                                           }];
         
         [dataTask resume];

     }
     else{
         [self.delegate performSelector:@selector(VelocityProcessorCaptureAllServerRequestFailedWithErrorMessage:) withObject:@"Network Error!!"];
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
