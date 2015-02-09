////
////  PaymentGatewayHelper.h
////  PDXEnterpriseSolutions
////
////  Created by Chetu on 09/01/15.
////  Copyright (c) 2015 PDX. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//
//enum TRANSTYPE{
//    TRANSTYPESALE  =0,
//    TRANSTYPEADJUSTMENT,
//    TRANSTYPEAUTH  ,
//    TRANSTYPERETURN ,
//    TRANSTYPEVOID  ,
//    TRANSTYPEFORCE ,
//    TRANSTYPECAPTURE ,
//    TRANSTYPECAPTUREALL  ,
//    TRANSTYPEREPEATSALE   ,
//};
//enum TRXCARDTYPE{
//    
//    CREDITCARD = 0,
//    DEBITCARD
//};
//
//@class TRXVaultResponseOb;
//
//@interface PaymentGatewayHelper : NSObject<NSURLSessionDelegate,NSURLSessionDataDelegate,NSXMLParserDelegate>{
//    
//    NSString *currentParsedElement;
//    NSString *parserStartElement;
//    NSString *cardTypeString;
//    NSMutableDictionary *xmlDataDict;
//}
//
//-(void)sendPOSTXMLRequestForCardType:(NSInteger)cardType;
//@end
//
//
//@interface TRXVaultResponseOb : NSObject
//
//@property(nonatomic,assign) NSInteger result;
//
//
//@property(nonatomic,strong) NSString * responseMsg;
//@property(nonatomic,strong) NSString * message;
//@property(nonatomic,strong) NSString * pnRef;
//@property(nonatomic,strong) NSString * authCode;
//@property(nonatomic,strong) NSString * hostCode;
//
//@property(nonatomic,strong) NSString * getAVSResult;
//@property(nonatomic,strong) NSString * getAVSResultTxt;
//@property(nonatomic,strong) NSString * getStreetMatchTXT;
//@property(nonatomic,strong) NSString * getZipMatchTXT;
//@property(nonatomic,strong) NSString * getCommercialCard;
//@property(nonatomic,strong) NSString * extData;
//
//
//@end