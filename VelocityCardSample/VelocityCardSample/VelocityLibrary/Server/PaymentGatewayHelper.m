////
////  PaymentGatewayHelper.m
////  PDXEnterpriseSolutions
////
////  Created by Chetu on 09/01/15.
////  Copyright (c) 2015 PDX. All rights reserved.
////
//
//#import "PaymentGatewayHelper.h"
//#import "VelocityProcessorConstant.h"
//
//@implementation PaymentGatewayHelper
//
//
//
//-(void)sendPOSTXMLRequestForCardType:(NSInteger)cardType{
//
//    xmlDataDict = [NSMutableDictionary new];
//    
//    switch (cardType) {
//        case CREDITCARD:
//            cardTypeString=@"ProcessCreditCard";
//            break;
//        case DEBITCARD:
//            cardTypeString=@"ProcessDebitCard";
//            break;
//            
//        default:
//            cardTypeString=@"";
//            break;
//    }
//    
//    NSDictionary *inputDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                               @"DevJory1219",TRXVAULTUSERNAME,
//                               @"Jorydev1", TRXVAULTPASSWORD,
//                               @"Auth", TRXVAULTTRANSTYPE,
//                               @"4055016727870315", TRXVAULTCARDNUM,
//                               @"0524", TRXVAULTEXPDATE,
//                               @"John Doe", TRXVAULTNAMEONCARD,
//                               @"1.00", TRXVAULTAMOUNT,
//                               @"",TRXVAULTEXTDATA,
//                               @"", TRXVAULTMAGDATA,
//                               @"",TRXVAULTINVNUM,
//                               @"",TRXVAULTPNREF,
//                               @"",TRXVAULTZIP,
//                               @"",TRXVAULTSTREET,
//                               @"",TRXVAULTCVNUM,
//                               nil];
//
//    
//    
//    NSMutableString *soapString =[NSMutableString new];
//    
//    [soapString appendString:[NSString stringWithFormat:
//                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
//     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
//     "<soap:Body>\n"
//     "<%@ xmlns=\"http://TPISoft.com/SmartPayments/\">\n",cardTypeString]];
//    for (NSString *key in inputDict.allKeys) {
//        
//            [soapString appendString:[NSString stringWithFormat:@"<%@>%@</%@>\n",key,[inputDict objectForKey:key],key]];
//    }
//    [soapString appendString:[NSString stringWithFormat:
//     @"</%@>\n"
//     "</soap:Body>\n"
//     "</soap:Envelope>\n",cardTypeString]];
//    
//    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//    
//    NSURL *url = [NSURL URLWithString:TRXPROCESSCREDITCARDURL];
//    
//    
//   /* switch (transTypeValue) {
//        case TRANSTYPESALE:
//            
//            break;
//        case TRANSTYPEADJUSTMENT:
//            
//            break;
//        case TRANSTYPEAUTH:
//            
//            break;
//        case TRANSTYPERETURN:
//            
//            break;
//        case TRANSTYPEVOID:
//            
//            break;
//        case TRANSTYPEFORCE:
//            
//            break;
//        case TRANSTYPECAPTURE:
//            
//            break;
//        case TRANSTYPECAPTUREALL:
//            
//            break;
//        case TRANSTYPEREPEATSALE:
//            
//            break;
//        default:
//            [[[UIAlertView alloc]initWithTitle:@"Tansaction Invalid" message:@"Invalid Transaction Type" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
//            break;
//    } 
//    */
//    
//    NSMutableURLRequest *urlReq = [NSMutableURLRequest requestWithURL:url];
//             NSString *msgLength = [NSString stringWithFormat:@"%d", (int)[soapString length]];
//    
//    [urlReq setHTTPMethod:@"POST"];
//    [urlReq setHTTPBody:[soapString dataUsingEncoding:NSUTF8StringEncoding]];
//    [urlReq setTimeoutInterval:30];
//    [urlReq addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [urlReq addValue: @"http://TPISoft.com/SmartPayments/ProcessCreditCard" forHTTPHeaderField:@"SOAPAction"];
//    [urlReq addValue: msgLength forHTTPHeaderField:@"Content-Length"];
//
//    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlReq];
//    
//    [dataTask resume];
//}
//
//#pragma mark
//#pragma mark - NSURLSession Data Delegates
//
//-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
//    
//    completionHandler(NSURLSessionResponseAllow);
//}
//
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
//didCompleteWithError:(NSError *)error
//{
//    if(error == nil)
//    {
//        NSLog(@"Download is Succesfull");
//    }
//    else
//        NSLog(@"Error %@",[error userInfo]);
//}
//-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
//    NSString *theXML = [[NSString alloc] initWithBytes:
//                        [data bytes] length:[data length] encoding:NSUTF8StringEncoding];
//    NSLog(@"Data = %@",theXML);
//    
//     NSData *xmlData = [theXML dataUsingEncoding:NSASCIIStringEncoding];
//    
//    NSXMLParser *xmlParser = [[NSXMLParser alloc]initWithData:xmlData];
//    
//    [xmlParser setDelegate:self];
//    // Run the parser
//    BOOL parsingResult = [xmlParser parse];
//    NSLog(@"Bool:%d",parsingResult);
//}
//
//
//#pragma mark 
//#pragma mark - NSXMLParser delegates
//
//-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
//    
//
//    if ([elementName isEqualToString:[NSString stringWithFormat:@"%@Result",cardTypeString]]) {
//        parserStartElement=elementName;
//        currentParsedElement=@"";
//    }
//    else{
//        currentParsedElement=elementName;
//    }
//}
//
//-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
//    
//    if ([parserStartElement isEqualToString:[NSString stringWithFormat:@"%@Result",cardTypeString]]&&(currentParsedElement.length>0)) {
//     
//        [xmlDataDict setObject:string forKey:currentParsedElement];
//    }
//}
//
//-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
//    
//    if ([elementName isEqualToString:[NSString stringWithFormat:@"%@Result",cardTypeString]]) {
//        parserStartElement=@"";
//         NSLog(@"End Element:%@",xmlDataDict);
//    }
//   
//}
//-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
//    NSLog(@"Error during parser:%@",parseError.description);
//}
//
//
//@end
//
//
//
//@implementation TRXVaultResponseOb
//
//@end
