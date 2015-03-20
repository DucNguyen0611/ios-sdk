//
//  VelocityProcessorAuthWAndWOCapture.m
//  VelocityCardSample
//
//  Created by Amit Aman on 09/02/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "VelocityProcessorAuthWAndWOCapture.h"
#import "VelocityPaymentTransaction.h"
#import "VelocityProcessorConstant.h"
#import "XMLReader.h"
#import "ErrorPaymentResponse.h"
#import "BankcardTransactionResponsePro.h"
#import "Reachability.h"
@implementation VelocityProcessorAuthWAndWOCapture{
    ErrorPaymentResponse *errObj;
    BankcardTransactionResponsePro *banCardObj;
    VelocityPaymentTransaction *PaymentObj;
}
/**
 *  check network status
 *
 *  @return true for connected
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
 *  Call service for Auth And Capture With And without token
 *
 *  @param appProfileID
 *  @param merchantID         
 *  @param workDFlowID
 *  @param sessionToken
 *  @param isTestAccount
 *  @param isWithToken
 *  @param addressObj
 *  @param authTxObj
 *  @param avsObj
 *  @param billingDataObj
 *  @param cardDataObj
 *  @param cardholderObj
 *  @param cardsecurityObj
 *  @param customerDataObj
 *  @param ecommerceObj
 *  @param reportingDataObj
 *  @param trnderDataObj
 *  @param track1dataObj
 *  @param transactionObj
 *  @param transectionDataObj
 */
-(void)authorizeAndCaptureWithTokenAndAppprofileid:(NSString *)appProfileID andMerchentID:(NSString *)merchantID andWorkFlowID:(NSString *)workDFlowID andSessionToken:(NSString *)sessionToken andIsTestAccount:(BOOL)isTestAccount andIsWithToken:(BOOL)isWithToken withModalObjectsAddress:(Address *)addressObj authoriseTransaction:(AuthorizeTransaction *)authTxObj andAvsData:(AVSData *)avsObj andBillingData:(BillingData *)billingDataObj and:(CardData *)cardDataObj and:(CardHolderName *)cardholderObj and:(CardSecurityData *)cardsecurityObj and:(CustomerData *)customerDataObj and:(ECommerceSecurityData *)ecommerceObj and:(ReportingData*)reportingDataObj and:(TenderData *)trnderDataObj and:(Track1Data *)track1dataObj and:(Transaction *)transactionObj and:(TransactionData *)transectionDataObj{
    if ([self CheckNetworConnectivity ]== YES) {
    NSString *newStr = [sessionToken substringWithRange:NSMakeRange(1, [sessionToken length] - 2)];
    
    
    NSString *appendedString=[newStr stringByAppendingString:@" : "];
    NSData *tokenData = [appendedString dataUsingEncoding:NSUTF8StringEncoding];
    NSString * stringBase64 = [tokenData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    
    PaymentObj =[PaymentObjecthandler getModelObject];
    
    NSString *xmlMainString =kHeadr_Xml;
   
    //AuthorizeTransaction stars
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"\n<AuthorizeAndCaptureTransaction xmlns=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions/Rest\" xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" i:type=\"AuthorizeAndCaptureTransaction\">\n<ApplicationProfileId>%@</ApplicationProfileId>\n<MerchantProfileId>%@</MerchantProfileId>\n<Transaction xmlns:ns1=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions/Bankcard\" i:type=\"ns1:BankcardTransaction\">",appProfileID,merchantID]];
    
    //customerdata class start
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"\n<ns2:CustomerData xmlns:ns2=\"%@\">\n",kXml_Base_Url]];
    //billing data class statrt
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:BillingData>\n"]];
    
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Name i:nil=\"true\"/>\n"]];
    //address class starts
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Address>\n"]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Street1>%@</ns2:Street1>\n",PaymentObj.street]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Street2 i:nil=\"true\"/>\n"]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:City>%@</ns2:City>\n",PaymentObj.city]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:StateProvince>CO</ns2:StateProvince>\n"]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:PostalCode>%@</ns2:PostalCode>\n",PaymentObj.postalCode]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:CountryCode>%@</ns2:CountryCode>\n",PaymentObj.countryCode]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ns2:Address>\n"]];
    //address class closed
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:BusinessName>%@</ns2:BusinessName>\n",PaymentObj.businnessName]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Phone i:nil=\"true\"/>\n"]];
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Fax i:nil=\"true\"/>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:Email i:nil=\"true\"/>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ns2:BillingData>\n"]];
    //billing data finishrd
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:CustomerId>%@</ns2:CustomerId>\n",PaymentObj.CustomerId]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:CustomerTaxId i:nil=\"true\"/>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns2:ShippingData i:nil=\"true\"/>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ns2:CustomerData>\n"]];
    //customer class data end
    //reporting data starts
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns3:ReportingData xmlns:ns3=\"%@\">\n",kXml_Base_Url]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns3:Comment>%@</ns3:Comment>\n",PaymentObj.comment]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns3:Description>%@</ns3:Description>\n",PaymentObj.discription]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns3:Reference>%@</ns3:Reference>\n",PaymentObj.reportingDataReference]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ns3:ReportingData>\n"]];
    //reporting data ends
    //tender data stars
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:TenderData>\n"]];
    //with token
    if (isWithToken) {
        xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns4:PaymentAccountDataToken xmlns:ns4=\"%@\">%@</ns4:PaymentAccountDataToken> \n",kXml_Base_Url,PaymentObj.paymentAccountDataToken]];
    }
    //without token
    else
        xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns4:PaymentAccountDataToken xmlns:ns4=\"%@\" i:nil=\"true\"/>\n",kXml_Base_Url]];
    
    
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns5:SecurePaymentAccountData xmlns:ns5=\"%@\" i:nil=\"true\"/>\n",kXml_Base_Url]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns6:EncryptionKeyId xmlns:ns6=\"%@\" i:nil=\"true\"/>\n",kXml_Base_Url]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns7:SwipeStatus xmlns:ns7=\"%@\" i:nil=\"true\"/>\n",kXml_Base_Url]];
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
    //tender data ends
    
    //transaction data starts
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:TransactionData>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns8:Amount xmlns:ns8=\"%@\">%@</ns8:Amount>\n",kXml_Base_Url,PaymentObj.amount]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns9:CurrencyCode xmlns:ns9=\"%@\">%@</ns9:CurrencyCode>\n",kXml_Base_Url,PaymentObj.currencyCode]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns10:TransactionDateTime xmlns:ns10=\"%@\">%@</ns10:TransactionDateTime>\n",kXml_Base_Url,PaymentObj.transactionDateTime]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns11:CampaignId xmlns:ns11=\"%@\" i:nil=\"true\"/>\n",kXml_Base_Url]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"    <ns12:Reference xmlns:ns12=\"%@\">xyt</ns12:Reference>\n",kXml_Base_Url]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:AccountType>%@</ns1:AccountType>\n",PaymentObj.accountType]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:ApprovalCode i:nil=\"true\"/>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CashBackAmount>%@</ns1:CashBackAmount>\n",PaymentObj.cashBackAmount]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"    <ns1:CustomerPresent>%@</ns1:CustomerPresent>\n",PaymentObj.customerPresent]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:EmployeeId>%@</ns1:EmployeeId>\n",PaymentObj.employeeId]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:EntryMode>%@</ns1:EntryMode>\n",PaymentObj.entryMode]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:GoodsType>%@</ns1:GoodsType>\n",PaymentObj.goodsType]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:IndustryType>%@</ns1:IndustryType>\n",PaymentObj.industryType]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:InternetTransactionData i:nil=\"true\"/>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:InvoiceNumber>%@</ns1:InvoiceNumber>\n",PaymentObj.invoiceNumber]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:OrderNumber>%@</ns1:OrderNumber>\n",PaymentObj.orderNumber]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:IsPartialShipment>false</ns1:IsPartialShipment>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:SignatureCaptured>false</ns1:SignatureCaptured>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:FeeAmount>0.0</ns1:FeeAmount>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:TerminalId i:nil=\"true\"/>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:LaneId i:nil=\"true\"/>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:TipAmount>0.0</ns1:TipAmount>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:BatchAssignment i:nil=\"true\"/>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:PartialApprovalCapable>NotSet</ns1:PartialApprovalCapable>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:ScoreThreshold i:nil=\"true\"/>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"<ns1:IsQuasiCash>false</ns1:IsQuasiCash>\n"]];
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</ns1:TransactionData>\n"]];
    //transaction data ends
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</Transaction>\n"]];
    // tansaction ends
    xmlMainString = [xmlMainString stringByAppendingString:[NSString stringWithFormat:@"</AuthorizeAndCaptureTransaction>"]];
    //authorization ends
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url;
    if (isTestAccount)
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Txn/%@",kServer_Test_Url,workDFlowID]];
    else
        url= [NSURL URLWithString:[NSString stringWithFormat:@"%@Txn/%@",kServer_Url,workDFlowID]];
    
    NSMutableURLRequest *urlReq = [[NSMutableURLRequest alloc]initWithURL:url];
    [urlReq setTimeoutInterval:30];
    //[urlReq addValue: @"http://schemas.ipcommerce.com/CWS/v2.0/Transactions/Rest" forHTTPHeaderField:@"SOAPAction"];
    [urlReq setHTTPBody:[xmlMainString dataUsingEncoding:NSUTF8StringEncoding]];
    [urlReq setHTTPMethod:NSLocalizedString(@"POST", nil)];
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
                                                      [self.delegate performSelector:@selector(VelocityProcessorAuthNCaptureWTokenServerRequestFailedWithErrorMessage:) withObject:errObj];
                                                  }
                                                  else{
                                                      banCardObj= [ResponseObjecthandler getModelObjectWithDic:dict];
                                                      banCardObj.statusCodeHttpResponse =httpCode;

                                                      NSLog(@"bancard objects ****%@",banCardObj);
                                                      [self.delegate performSelector:@selector(VelocityProcessorAuthNCaptureWTokenServerRequestFinishedWithSuccess:) withObject:banCardObj];
                                                  }
                                                  
                                                  
                                                  
                                              }
                                              
                                          }
                                          else{
                                              
                                              [self.delegate performSelector:@selector(VelocityProcessorAuthNCaptureWTokenServerRequestFailedWithErrorMessage:) withObject:error];
                                              
                                              
                                          }
                                      }];
    
    
    [dataTask resume];

    }
    else{
        [self.delegate performSelector:@selector(VelocityProcessorAuthNCaptureWTokenServerRequestFailedWithErrorMessage:) withObject:@"Network Error!!"];
    }

}
//ssl verification
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler{
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}

@end
