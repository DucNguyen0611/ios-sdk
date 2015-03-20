//
//  VelocityProcessor AuthorizeTransaction.m
//  VelocityCardSample
//
//  Created by Chetu on 22/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "VelocityProcessorAuthorizeTransaction.h"
#import "VelocityProcessorConstant.h"
#import "XMLReader.h"
#import "VelocityProcessor.h"
#import "BankcardTransactionResponsePro.h"
#import "VelocityPaymentTransaction.h"
#import "ErrorPaymentResponse.h"
#import "VelocityResponse.h"
#import "Reachability.h"
@implementation VelocityProcessorAuthorizeTransaction{
    ErrorPaymentResponse *errObj;
    BankcardTransactionResponsePro *banCardObj;
}
/**
 *  check networ status
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
 *  service call for verify method
 *
 *  @param sessionToken
 *  @param appProfileId
 *  @param merchantProfileId
 *  @param workflowId
 *  @param isTestAccount
 */
-(void)verifySessionTokenInXML:(NSString*)sessionToken forAppProfileId:(NSString *)appProfileId forMerchantProfileId:(NSString *)merchantProfileId forWorkflowId:(NSString *)workflowId andType:(BOOL )isTestAccount{
    if ([self CheckNetworConnectivity ]== YES) {
        
  
    
    NSString *newStr = [sessionToken substringWithRange:NSMakeRange(1, [sessionToken length] - 2)];
    
    
    NSString *appendedString=[newStr stringByAppendingString:@" : "];
    NSData *tokenData = [appendedString dataUsingEncoding:NSUTF8StringEncoding];
    NSString * stringBase64 = [tokenData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    
    VelocityPaymentTransaction *obj =[PaymentObjecthandler getModelObject];
        /**
         *  xml for request starts
         */
    NSString *xmlString=[NSString stringWithFormat:@"<AuthorizeTransaction xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions/Rest\" i:type=\"AuthorizeTransaction\">\n<ApplicationProfileId>%@</ApplicationProfileId>\n<MerchantProfileId>%@</MerchantProfileId>\n<Transaction\nxmlns:ns1=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions/Bankcard\"\ni:type=\"ns1:BankcardTransaction\">\n<ns1:TenderData>\n<ns1:CardData>\n<ns1:CardType>%@</ns1:CardType>\n<ns1:CardholderName>%@</ns1:CardholderName>\n<ns1:PAN>%@</ns1:PAN>\n<ns1:Expire>%@</ns1:Expire>\n<ns1:Track1Data i:nil=\"true\">%@</ns1:Track1Data>\n</ns1:CardData>\n<ns1:CardSecurityData>\n<ns1:AVSData>\n",appProfileId,merchantProfileId,obj.cardType,obj.cardholderName,obj.panNumber,obj.expiryDate,obj.track1Data ];
        /**
         *  checking postal code available or not
         */
    if (!obj.postalCode.length >=1) {
        xmlString = [xmlString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CardholderName i:nil=\"true\"/>\n<ns1:Street i:nil=\"true\"/>\n<ns1:City i:nil=\"true\"/>\n<ns1:StateProvince i:nil=\"true\"/>\n<ns1:PostalCode i:nil=\"true\"/>\n<ns1:Phone i:nil=\"true\"/>\n<ns1:Email i:nil=\"true\"/>\n</ns1:AVSData>\n<ns1:CVDataProvided>%@</ns1:CVDataProvided>\n<ns1:CVData>%@</ns1:CVData>\n<ns1:KeySerialNumber i:nil=\"true\"/>\n<ns1:PIN i:nil=\"true\"/>\n<ns1:IdentificationInformation i:nil=\"true\"/>\n</ns1:CardSecurityData>\n<ns1:EcommerceSecurityData\ni:nil=\"true\"/>\n</ns1:TenderData>\n<ns1:TransactionData>\n<ns8:Amount\nxmlns:ns8=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns8:Amount>\n<ns9:CurrencyCode\nxmlns:ns9=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns9:CurrencyCode>\n<ns10:TransactionDateTime\nxmlns:ns10=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns10:TransactionDateTime>\n<ns1:AccountType>%@</ns1:AccountType>\n<ns1:CustomerPresent>%@</ns1:CustomerPresent>\n<ns1:EmployeeId>%@</ns1:EmployeeId>\n<ns1:EntryMode>%@</ns1:EntryMode>\n<ns1:IndustryType>%@</ns1:IndustryType>\n<ns1:InvoiceNumber>%@</ns1:InvoiceNumber>\n<ns1:OrderNumber>%@</ns1:OrderNumber>\n<ns1:TipAmount>%@</ns1:TipAmount>\n</ns1:TransactionData>\n</Transaction>\n</AuthorizeTransaction>",obj.cvDataProvided,obj.cVData,obj.amount,obj.currencyCode,obj.transactionDateTime,obj.accountType,obj.customerPresent,obj.employeeId,obj.entryMode,obj.industryType,obj.invoiceNumber,obj.orderNumber,obj.tipAmount]];
    }
    else
    xmlString = [xmlString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CardholderName i:nil=\"true\">%@</ns1:CardholderName>\n<ns1:Street>%@</ns1:Street>\n<ns1:PostalCode>%@</ns1:PostalCode>\n<ns1:City>%@</ns1:City>\n<ns1:StateProvince>%@</ns1:StateProvince>\n<ns1:Phone>%@</ns1:Phone>\n<ns1:Email i:nil=\"true\">%@</ns1:Email>\n</ns1:AVSData>\n<ns1:CVDataProvided>%@</ns1:CVDataProvided>\n<ns1:CVData>%@</ns1:CVData>\n<ns1:KeySerialNumber i:nil=\"true\">%@</ns1:KeySerialNumber>\n<ns1:PIN i:nil=\"true\">%@</ns1:PIN>\n<ns1:IdentificationInformation i:nil=\"true\">%@</ns1:IdentificationInformation>\n</ns1:CardSecurityData>\n<ns1:EcommerceSecurityData i:nil=\"true\">%@</ns1:EcommerceSecurityData>\n</ns1:TenderData>\n<ns1:TransactionData>\n<ns8:Amount\nxmlns:ns8=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns8:Amount>\n<ns9:CurrencyCode\nxmlns:ns9=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns9:CurrencyCode>\n<ns10:TransactionDateTime\nxmlns:ns10=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns10:TransactionDateTime>\n<ns1:AccountType>%@</ns1:AccountType>\n<ns1:CustomerPresent>%@</ns1:CustomerPresent>\n<ns1:EmployeeId>%@</ns1:EmployeeId>\n<ns1:EntryMode>%@</ns1:EntryMode>\n<ns1:IndustryType>%@</ns1:IndustryType>\n<ns1:InvoiceNumber>%@</ns1:InvoiceNumber>\n<ns1:OrderNumber>%@</ns1:OrderNumber>\n<ns1:TipAmount>%@</ns1:TipAmount>\n</ns1:TransactionData>\n</Transaction>\n</AuthorizeTransaction>",obj.cardholderName,obj.street,obj.postalCode,obj.city,obj.state,obj.phone,obj.email,obj.cvDataProvided,obj.cVData,obj.keySerialNumber,obj.panNumber,obj.identificationInformation,obj.ecommerceSecurityData,obj.amount,obj.currencyCode,obj.transactionDateTime,obj.accountType,obj.customerPresent,obj.employeeId,obj.entryMode,obj.industryType,obj.invoiceNumber,obj.orderNumber,obj.tipAmount]];
        
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url;
    if (isTestAccount)
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Txn/%@/verify",kServer_Test_Url,workflowId]];
    else
        url= [NSURL URLWithString:[NSString stringWithFormat:@"%@Txn/%@/verify",kServer_Url,workflowId]];
        
    NSMutableURLRequest *urlReq = [NSMutableURLRequest requestWithURL:url];
    [urlReq setTimeoutInterval:30];
    [urlReq setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [urlReq setHTTPMethod:NSLocalizedString(@"POST", nil)];
    [urlReq addValue:NSLocalizedString(@"application/xml",nil) forHTTPHeaderField:NSLocalizedString(@"Accept",nil)];
    [urlReq setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
    [urlReq setValue:[NSString stringWithFormat:@"Basic %@",stringBase64] forHTTPHeaderField:kAuthorization];
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlReq
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      
            {
                NSString *theXML = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                 NSString*httpCode= [NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
                NSDictionary * dict = [NSDictionary dictionaryWithDictionary:[XMLReader dictionaryForXMLString:theXML error:nil]];
                NSArray *dictNameArray =[dict allKeys];
                /**
                 *  Parsing response
                 */
    if(error==nil && theXML.length>0){
        if(self.delegate != nil && ([self.delegate conformsToProtocol:@protocol(VelocityProcessorAuthTXDelegate)])){
            if ([dictNameArray containsObject:kErrorResponse ]) {
                errObj =[ErrorObjecthandler getModelObjectWithDic:dict];
                errObj.statusCodeHttpResponse = httpCode;
                [self.delegate performSelector:@selector(VelocityProcessorAuthTXServerRequestFailedWithErrorMessage:) withObject:errObj];
            }
            else if ([dictNameArray containsObject:@"BankcardTransactionResponsePro"]){
                banCardObj= [ResponseObjecthandler getModelObjectWithDic:dict];
                banCardObj.statusCodeHttpResponse =httpCode;
                [self.delegate performSelector:@selector(VelocityProcessorAuthTXServerRequestFinishedWithSuccess:) withObject:banCardObj];
                }
            else
                [self.delegate performSelector:@selector(VelocityProcessorAuthTXServerRequestFailedWithErrorMessage:) withObject:@"Request/Server Error"];
            }
    }
    else{
                                              
        [self.delegate performSelector:@selector(VelocityProcessorAuthTXServerRequestFailedWithErrorMessage:) withObject:@"Request/Server Error"];
        }
}];
    [dataTask resume];
    }
    else{
        [self.delegate performSelector:@selector(VelocityProcessorSignOnServerRequestFailedWithErrorMessage:) withObject:@"Network Error!!"];
    }

}
//cheque ssl
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler{
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}


@end
