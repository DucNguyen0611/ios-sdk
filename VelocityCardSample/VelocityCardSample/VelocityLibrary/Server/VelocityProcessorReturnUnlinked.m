//
//  VelocityProcessorReturnUnlinked.m
//  VelocityCardSample
//
//  Created by Chetu on 12/02/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "VelocityProcessorReturnUnlinked.h"
#import "VelocityPaymentTransaction.h"
#import "VelocityProcessorConstant.h"
#import "XMLReader.h"
#import "ErrorPaymentResponse.h"
#import "BankcardTransactionResponsePro.h"
#import "BancardCaptureResponse.h"
#import "Reachability.h"
@implementation VelocityProcessorReturnUnlinked{
    ErrorPaymentResponse *errObj;
    BankcardTransactionResponsePro *banCardObj;
    VelocityPaymentTransaction *PaymentObj;
    BancardCaptureResponse *captureObj;
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
/**
 *  Call service for ReturnedUnlinked method
 *
 *  @param appProfileID
 *  @param merchantID
 *  @param workDFlowID
 *  @param sessionToken
 *  @param isTestAccount
 */
-(void)returnUnLinkedAppprofileid:(NSString *)appProfileID andMerchentID:(NSString *)merchantID andWorkFlowID:(NSString *)workDFlowID andSessionToken:(NSString *)sessionToken andIsWithToken:(BOOL)isWithToken andIsTestAccount:(BOOL)isTestAccount{
    if ([self CheckNetworConnectivity ]== YES) {
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
    
    PaymentObj = [PaymentObjecthandler getModelObject];
        /**
         *  Xml for requesting server
         */
    NSString *xmlMainString =kHeadr_Xml;
    
    xmlMainString = [xmlMainString stringByAppendingString:@"\n<ReturnTransaction xmlns=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions/Rest\"\n"];
    xmlMainString = [xmlMainString stringByAppendingString:@"xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" i:type=\"ReturnTransaction\">\n"];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ApplicationProfileId>%@</ApplicationProfileId>\n",appProfileID]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<BatchIds xmlns:d2p1=\"http://schemas.microsoft.com/2003/10/Serialization/Arrays\" >%@</BatchIds>\n",PaymentObj.batchID]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<MerchantProfileId>%@</MerchantProfileId>\n",merchantID]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<Transaction xmlns:ns1=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions/Bankcard\" i:type=\"ns1:BankcardTransaction\">\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:CustomerData xmlns:ns2=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">\n"]];

    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:BillingData>\n"]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Name i:nil=\"true\" >%@</ns2:Name>\n",PaymentObj.cardholderName]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Address>\n"]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Street1>%@</ns2:Street1>\n",PaymentObj.street]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Street2 i:nil=\"true\" >%@</ns2:Street2>\n",PaymentObj.street2]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:City>%@</ns2:City>\n",PaymentObj.city]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:StateProvince>%@</ns2:StateProvince>\n",PaymentObj.stateProvince]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:PostalCode>%@</ns2:PostalCode>\n",PaymentObj.postalCode]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:CountryCode>%@</ns2:CountryCode>\n",PaymentObj.countryCode]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@" </ns2:Address>\n"]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:BusinessName>%@</ns2:BusinessName>\n",PaymentObj.businnessName]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Phone i:nil=\"true\" >%@</ns2:Phone>\n",PaymentObj.phone]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Fax i:nil=\"true\" >%@</ns2:Fax>\n",PaymentObj.fax]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Email i:nil=\"true\" >%@</ns2:Email>\n",PaymentObj.email]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ns2:BillingData>\n"]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:CustomerId>%@</ns2:CustomerId>\n",PaymentObj.CustomerId]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:CustomerTaxId i:nil=\"true\" >%@</ns2:CustomerTaxId>\n",PaymentObj.customerTaxId]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:ShippingData i:nil=\"true\" >%@</ns2:ShippingData>\n",PaymentObj.shippingData]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ns2:CustomerData>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns3:ReportingData xmlns:ns3=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns3:Comment>%@</ns3:Comment>\n",PaymentObj.comment]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@" <ns3:Description>%@</ns3:Description>\n",PaymentObj.discription]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns3:Reference>%@</ns3:Reference>\n",PaymentObj.reportingDataReference]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ns3:ReportingData>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@" <ns1:TenderData>\n"]];
        if (isWithToken) {
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns4:PaymentAccountDataToken xmlns:ns4=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns4:PaymentAccountDataToken>\n",PaymentObj.paymentAccountDataToken]];
        }
        else{
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns4:PaymentAccountDataToken xmlns:ns4=\"%@\" i:nil=\"true\"/>\n",kXml_Base_Url]];
            
            if (PaymentObj.securePaymentAccountData.length>0 && PaymentObj.encryptionKeyId.length>0) {
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns5:SecurePaymentAccountData xmlns:ns5=\"%@\">%@</ns5:SecurePaymentAccountData>\n",kXml_Base_Url,PaymentObj.securePaymentAccountData]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns6:EncryptionKeyId xmlns:ns6=\"%@\">%@</ns6:EncryptionKeyId>\n",kXml_Base_Url,PaymentObj.encryptionKeyId]];
                if (PaymentObj.swipeStatus.length >0 && PaymentObj.identificationInformation.length >0) {
                    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns7:SwipeStatus xmlns:ns7=\"%@\" >%@</ns7:SwipeStatus>\n",kXml_Base_Url,PaymentObj.swipeStatus]];
                    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CardSecurityData>"]];
                    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:IdentificationInformation>%@</ns1:IdentificationInformation>",PaymentObj.identificationInformation]];
                    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ns1:CardSecurityData>"]];
                    
                    
                }
                else
                    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns7:SwipeStatus xmlns:ns7=\"%@\" i:nil=\"true\">%@</ns7:SwipeStatus>\n",kXml_Base_Url,PaymentObj.swipeStatus]];
                
            }
            else{
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns5:SecurePaymentAccountData xmlns:ns5=\"%@\" i:nil=\"true\"/>\n",kXml_Base_Url]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns6:EncryptionKeyId xmlns:ns6=\"%@\" i:nil=\"true\"/>\n",kXml_Base_Url]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns7:SwipeStatus xmlns:ns7=\"%@\" i:nil=\"true\"/>\n",kXml_Base_Url]];
            }
        }
    
        if (isWithToken)
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:EcommerceSecurityData i:nil=\"true\"/>\n"]];
        //card data starts
        if (isWithToken) {
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CardData>\n"]];
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CardType i:nil=\"true\"/>\n"]];
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:PAN i:nil=\"true\"/>\n"]];
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:Expire i:nil=\"true\"/>\n"]];
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:Track1Data  i:nil=\"true\"/>\n"]];
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@" </ns1:CardData>\n"]];
        }
        else if(PaymentObj.securePaymentAccountData.length>0 && PaymentObj.encryptionKeyId.length>0){
            
        }
        else if([PaymentObj.entryMode isEqualToString:@"TrackDataFromMSR"]){
            if ([PaymentObj.track1Data isEqualToString:@""]||[PaymentObj.track1Data isEqualToString:@"null"]) {
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CardData>\n"]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CardType>%@</ns1:CardType>\n",PaymentObj.cardType]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:PAN i:nil=\"true\"/>\n"]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:Expire i:nil=\"true\"/>\n"]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:Track1Data i:nil=\"true\"/>\n"]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:Track2Data>%@</ns1:Track2Data>\n",PaymentObj.track2Data]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@" </ns1:CardData>\n"]];
                
            }
            else{
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CardData>\n"]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CardType>%@</ns1:CardType>\n",PaymentObj.cardType]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:PAN i:nil=\"true\"/>\n"]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:Expire i:nil=\"true\"/>\n"]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:Track1Data>%@</ns1:Track1Data>\n",PaymentObj.track1Data]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:Track2Data i:nil=\"true\"/>\n"]];
                xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@" </ns1:CardData>\n"]];
            }
        }
        else{
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CardData>\n"]];
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CardType>%@</ns1:CardType>\n",PaymentObj.cardType]];
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:PAN>%@</ns1:PAN>\n",PaymentObj.panNumber]];
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:Expire>%@</ns1:Expire>\n",PaymentObj.expiryDate]];
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:Track1Data i:nil=\"true\"/>\n"]];
            xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@" </ns1:CardData>\n"]];
            //card data ends
        }

    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ns1:TenderData>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:TransactionData>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns8:Amount xmlns:ns8=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns8:Amount>\n",PaymentObj.amount]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns9:CurrencyCode xmlns:ns9=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns9:CurrencyCode>\n",PaymentObj.currencyCode]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns10:TransactionDateTime xmlns:ns10=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns10:TransactionDateTime>\n",PaymentObj.transactionDateTime]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns11:CampaignId xmlns:ns11=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\" i:nil=\"true\" />\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns12:Reference xmlns:ns12=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns12:Reference>\n",PaymentObj.reportingDataReference]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@" <ns1:AccountType>%@</ns1:AccountType>\n",PaymentObj.accountType]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:ApprovalCode i:nil=\"true\" />\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CashBackAmount>%@</ns1:CashBackAmount>\n",PaymentObj.cashBackAmount]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CustomerPresent>%@</ns1:CustomerPresent>\n",PaymentObj.customerPresent]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:EmployeeId>%@</ns1:EmployeeId>\n",PaymentObj.employeeId]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:EntryMode>%@</ns1:EntryMode>\n",PaymentObj.entryMode]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:GoodsType>%@</ns1:GoodsType>\n",PaymentObj.goodsType]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:IndustryType>%@</ns1:IndustryType>\n",PaymentObj.industryType]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:InternetTransactionData i:nil=\"true\" />\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:InvoiceNumber />\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:OrderNumber>%@</ns1:OrderNumber>\n",PaymentObj.orderNumber]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:IsPartialShipment>%u</ns1:IsPartialShipment>\n",PaymentObj.isPartialShipment]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:SignatureCaptured>%u</ns1:SignatureCaptured>\n",PaymentObj.isSignatureCaptured]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:FeeAmount>%@</ns1:FeeAmount>\n",PaymentObj.FeeAmount]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:TerminalId i:nil=\"true\" />\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:LaneId i:nil=\"true\" />\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:TipAmount>%@</ns1:TipAmount>\n",PaymentObj.tipAmount]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:BatchAssignment i:nil=\"true\" />\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:PartialApprovalCapable>%@</ns1:PartialApprovalCapable>\n",PaymentObj.partialApprovalCapable]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:ScoreThreshold i:nil=\"true\" />\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:IsQuasiCash>%u</ns1:IsQuasiCash>\n",PaymentObj.isQuasiCash]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ns1:TransactionData>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@" </Transaction>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ReturnTransaction>\n"]];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url;
    if (isTestAccount)
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Txn/%@",kServer_Test_Url,workDFlowID]];
    
    else
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Txn/%@",kServer_Url,workDFlowID]];
        
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
                                           *  Parsing Response
                                           */
                                          if(error==nil && theXML.length>0){
                                              
                                              
                                              if(self.delegate != nil && ([self.delegate conformsToProtocol:@protocol(VelocityProcessorAuthWTokenDelegate)])){
                                                  if ([dictNameArray containsObject:kErrorResponse ]) {
                                                      
                                                      errObj =[ErrorObjecthandler getModelObjectWithDic:dict];
                                                      errObj.statusCodeHttpResponse = httpCode;
                                                      NSLog(@"error objects ****%@",errObj);
                                                      [self.delegate performSelector:@selector(VelocityProcessorReturnUnLinkedServerRequestFailedWithErrorMessage:) withObject:errObj];
                                                  }
                                                  else{
                                                      banCardObj = [ResponseObjecthandler getModelObjectWithDic:dict];
                                                      banCardObj.statusCodeHttpResponse = httpCode;
                                                      
                                                      NSLog(@"bancard objects ****%@",banCardObj);
                                                      [self.delegate performSelector:@selector(VelocityProcessorReturnUnLinkedServerRequestFinishedWithSuccess:) withObject:banCardObj];
                                                  }
                                                  
                                                  
                                                  
                                              }
                                              
                                          }
                                          else{
                                              
                                              [self.delegate performSelector:@selector(VelocityProcessorReturnUnLinkedServerRequestFailedWithErrorMessage:) withObject:error];
                                              
                                              
                                          }
                                      }];
    
    
    [dataTask resume];
    }
    else{
        [self.delegate performSelector:@selector(VelocityProcessorReturnUnLinkedServerRequestFailedWithErrorMessage:) withObject:@"Network Error!!"];
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
