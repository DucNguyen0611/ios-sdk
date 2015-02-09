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
@implementation VelocityProcessorAuthorizeTransaction{
    ErrorPaymentResponse *errObj;
    BankcardTransactionResponsePro *banCardObj;
}
-(void)verifySessionTokenInXML:(NSString*)sessionToken forAppProfileId:(NSString *)appProfileId forMerchantProfileId:(NSString *)merchantProfileId forWorkflowId:(NSString *)workflowId andType:(BOOL )isTestAccount{
   
    
    NSString *newStr = [sessionToken substringWithRange:NSMakeRange(1, [sessionToken length] - 2)];
    
    
    NSString *appendedString=[newStr stringByAppendingString:@" : "];
    NSData *tokenData = [appendedString dataUsingEncoding:NSUTF8StringEncoding];
    NSString * stringBase64 = [tokenData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    
    VelocityPaymentTransaction *obj =[PaymentObjecthandler getModelObject];
    
    NSString *xmlString=[NSString stringWithFormat:@"<AuthorizeTransaction xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions/Rest\" i:type=\"AuthorizeTransaction\">\n<ApplicationProfileId>%@</ApplicationProfileId>\n<MerchantProfileId>%@</MerchantProfileId>\n<Transaction\nxmlns:ns1=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions/Bankcard\"\ni:type=\"ns1:BankcardTransaction\">\n<ns1:TenderData>\n<ns1:CardData>\n<ns1:CardType>%@</ns1:CardType>\n<ns1:CardholderName>%@</ns1:CardholderName>\n<ns1:PAN>%@</ns1:PAN>\n<ns1:Expire>%@</ns1:Expire>\n<ns1:Track1Data\ni:nil=\"true\"/>\n</ns1:CardData>\n<ns1:CardSecurityData>\n<ns1:AVSData>\n",appProfileId,merchantProfileId,obj.cardType,obj.cardholderName,obj.panNumber,obj.expiryDate ];
    if (!obj.postalCode.length >=1) {
        xmlString = [xmlString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CardholderName i:nil=\"true\"/>\n<ns1:Street i:nil=\"true\"/>\n<ns1:City i:nil=\"true\"/>\n<ns1:StateProvince i:nil=\"true\"/>\n<ns1:PostalCode i:nil=\"true\"/>\n<ns1:Phone i:nil=\"true\"/>\n<ns1:Email i:nil=\"true\"/>\n</ns1:AVSData>\n<ns1:CVDataProvided>%@</ns1:CVDataProvided>\n<ns1:CVData>%@</ns1:CVData>\n<ns1:KeySerialNumber i:nil=\"true\"/>\n<ns1:PIN i:nil=\"true\"/>\n<ns1:IdentificationInformation i:nil=\"true\"/>\n</ns1:CardSecurityData>\n<ns1:EcommerceSecurityData\ni:nil=\"true\"/>\n</ns1:TenderData>\n<ns1:TransactionData>\n<ns8:Amount\nxmlns:ns8=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns8:Amount>\n<ns9:CurrencyCode\nxmlns:ns9=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns9:CurrencyCode>\n<ns10:TransactionDateTime\nxmlns:ns10=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns10:TransactionDateTime>\n<ns1:AccountType>%@</ns1:AccountType>\n<ns1:CustomerPresent>%@</ns1:CustomerPresent>\n<ns1:EmployeeId>%@</ns1:EmployeeId>\n<ns1:EntryMode>%@</ns1:EntryMode>\n<ns1:IndustryType>%@</ns1:IndustryType>\n<ns1:InvoiceNumber>%@</ns1:InvoiceNumber>\n<ns1:OrderNumber>%@</ns1:OrderNumber>\n<ns1:TipAmount>%@</ns1:TipAmount>\n</ns1:TransactionData>\n</Transaction>\n</AuthorizeTransaction>",obj.cvDataProvided,obj.cVData,obj.amount,obj.currencyCode,obj.transactionDateTime,obj.accountType,obj.customerPresent,obj.employeeId,obj.entryMode,obj.industryType,obj.invoiceNumber,obj.orderNumber,obj.tipAmount]];
    }
    else
    xmlString = [xmlString stringByAppendingString:[NSString stringWithFormat:@"<ns1:CardholderName i:nil=\"true\"/>\n<ns1:Street>%@</ns1:Street>\n<ns1:City i:nil=\"true\"/>\n<ns1:StateProvince i:nil=\"true\"/>\n<ns1:PostalCode>%@</ns1:PostalCode>\n<ns1:Phone i:nil=\"true\"/>\n<ns1:Email i:nil=\"true\"/>\n</ns1:AVSData>\n<ns1:CVDataProvided>%@</ns1:CVDataProvided>\n<ns1:CVData>%@</ns1:CVData>\n<ns1:KeySerialNumber i:nil=\"true\"/>\n<ns1:PIN i:nil=\"true\"/>\n<ns1:IdentificationInformation i:nil=\"true\"/>\n</ns1:CardSecurityData>\n<ns1:EcommerceSecurityData\ni:nil=\"true\"/>\n</ns1:TenderData>\n<ns1:TransactionData>\n<ns8:Amount\nxmlns:ns8=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns8:Amount>\n<ns9:CurrencyCode\nxmlns:ns9=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns9:CurrencyCode>\n<ns10:TransactionDateTime\nxmlns:ns10=\"http://schemas.ipcommerce.com/CWS/v2.0/Transactions\">%@</ns10:TransactionDateTime>\n<ns1:AccountType>%@</ns1:AccountType>\n<ns1:CustomerPresent>%@</ns1:CustomerPresent>\n<ns1:EmployeeId>%@</ns1:EmployeeId>\n<ns1:EntryMode>%@</ns1:EntryMode>\n<ns1:IndustryType>%@</ns1:IndustryType>\n<ns1:InvoiceNumber>%@</ns1:InvoiceNumber>\n<ns1:OrderNumber>%@</ns1:OrderNumber>    \n<ns1:TipAmount>%@</ns1:TipAmount>\n</ns1:TransactionData>\n</Transaction>\n</AuthorizeTransaction>",obj.street,obj.postalCode,obj.cvDataProvided,obj.cVData,obj.amount,obj.currencyCode,obj.transactionDateTime,obj.accountType,obj.customerPresent,obj.employeeId,obj.entryMode,obj.industryType,obj.invoiceNumber,obj.orderNumber,obj.tipAmount]];
    
    
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url;
    if (isTestAccount)
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Txn/%@/verify",kServer_Test_Url,workflowId]];
    
    else
        url= [NSURL URLWithString:[NSString stringWithFormat:@"%@Txn/%@/verify",kServer_Url,workflowId]];
    
    
    NSMutableURLRequest *urlReq = [NSMutableURLRequest requestWithURL:url];
    [urlReq setTimeoutInterval:30];
    //[urlReq addValue: @"http://schemas.ipcommerce.com/CWS/v2.0/Transactions/Rest" forHTTPHeaderField:@"SOAPAction"];
    [urlReq setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [urlReq setHTTPMethod:NSLocalizedString(@"POST", nil)];
    [urlReq addValue:NSLocalizedString(@"application/xml",nil) forHTTPHeaderField:NSLocalizedString(@"Accept",nil)];
    [urlReq setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
    [urlReq setValue:[NSString stringWithFormat:@"Basic %@",stringBase64] forHTTPHeaderField:kAuthorization];
    
    
 //   NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlReq];
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlReq
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      
            {
                                          
                
                NSString *theXML = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                 NSString*httpCode= [NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
                NSDictionary * dict = [NSDictionary dictionaryWithDictionary:[XMLReader dictionaryForXMLString:theXML error:nil]];
                NSArray *dictNameArray =[dict allKeys];
    
                
    if(error==nil && theXML.length>0){
                                              
                                              
        if(self.delegate != nil && ([self.delegate conformsToProtocol:@protocol(VelocityProcessorAuthTXDelegate)])){
            if ([dictNameArray containsObject:kErrorResponse ]) {
                
                errObj =[ErrorObjecthandler getModelObjectWithDic:dict];
                errObj.statusCodeHttpResponse = httpCode;
                NSLog(@"bancard objects ****%@",errObj);
                
                [self.delegate performSelector:@selector(VelocityProcessorAuthTXServerRequestFailedWithErrorMessage:) withObject:errObj];
            }
            else{
                banCardObj= [ResponseObjecthandler getModelObjectWithDic:dict];
                banCardObj.statusCodeHttpResponse =httpCode;
                
                NSLog(@"bancard objects ****%@",banCardObj);
                [self.delegate performSelector:@selector(VelocityProcessorAuthTXServerRequestFinishedWithSuccess:) withObject:banCardObj];
            }

            
            
            }
                                              
    }
    else{
                                              
        [self.delegate performSelector:@selector(VelocityProcessorAuthTXServerRequestFailedWithErrorMessage:) withObject:error];
        
                                              
        }
                                      }];

    
    [dataTask resume];
}

#pragma mark
#pragma mark - NSURLSession Data Delegates

//-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
////    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
////     errObj=[ErrorObjecthandler getmainObj];
////    NSString*httpCode= [NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
////    if ([httpCode isEqualToString:@"400"]) {
////        if ([errObj.errorId isEqualToString:@"5000"]) {
////            VelocityProcessor *obj =[[VelocityProcessor alloc]init];
////            [obj signOnWithIdentityToken];
////            return;
////        }
////        
////    }
////    else{
////    
////    if ([httpCode isEqualToString:@"201"]||[httpCode isEqualToString:@"200"]) {
////        banCardObj = [ResponseObjecthandler getModelObject];
////        banCardObj.statusCodeHttpResponse = httpCode;
////        
////
////    }
////    else{
////       
////        errObj.statusCodeHttpResponse = httpCode;
////        //[ErrorObjecthandler setModelObject:errObj];
////    }
////    
////    }
////    
////
//    
//    completionHandler(NSURLSessionResponseAllow);
//}
//
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
//didCompleteWithError:(NSError *)error
//{
//    if(error == nil)
//    {
//        
//        NSLog(@"Download is Succesfull");
//    }
//    else
//        NSLog(@"Error %@",[error userInfo]);
//}
//-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
////    NSString *theXML = [[NSString alloc] initWithBytes:
////                        [data bytes] length:[data length] encoding:NSUTF8StringEncoding];
////    NSLog(@"Data = %@",theXML);
////    
////    NSDictionary * dict = [NSDictionary dictionaryWithDictionary:[XMLReader dictionaryForXMLString:theXML error:nil]];
////    NSArray *dictNameArray =[dict allKeys];
////    
////    if ([dictNameArray containsObject:kErrorResponse ]) {
////    
////        errObj =[ErrorObjecthandler getModelObjectWithDic:dict];
////        NSLog(@"bancard objects ****%@",errObj);
////    }
////    else{
////    banCardObj= [ResponseObjecthandler getModelObjectWithDic:dict];
////    NSLog(@"bancard objects ****%@",banCardObj);
////    }
////    NSData *xmlData = [theXML dataUsingEncoding:NSASCIIStringEncoding];
////    
////    NSXMLParser *xmlParser = [[NSXMLParser alloc]initWithData:xmlData];
////    
////    //[xmlParser setDelegate:self];
////    // Run the parser
////    BOOL parsingResult = [xmlParser parse];
////    NSLog(@"Bool:%d",parsingResult);
//}
//
//
//#pragma mark
//#pragma mark - NSXMLParser delegates
//
////-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
////    
////    
////}
////
////-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
////  }
////
////-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
////           
////}
////-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
////    NSLog(@"Error during parser:%@",parseError.description);
////}
//

@end
