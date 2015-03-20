//
//  VelocityProcessorSignOn.m
//  VelocityCardSample
//
//  Created by Chetu on 21/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//
/**
 *  this class is used for requesting signOn method
 */
#import "VelocityProcessorSignOn.h"
#import "VelocityProcessorConstant.h"
#import "Reachability.h"

@implementation VelocityProcessorSignOn
@synthesize delegate;

static VelocityProcessorSignOn *scService = nil;

-(id)initServer
{
    if (!scService ) {
        
        scService =[[VelocityProcessorSignOn alloc] init];
    }

    return scService;
    

}
/*!
 *  @author sumit suman, 15-01-23 18:01:05
 *
 *  @brief  checking network connectivity
 *  @return if success returns true
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
/*!
 *  @author sumit suman, 15-01-23 18:01:39
 *
 *  @brief  method for signon call
 *  @param identityToken
 *  @param isTestAccount
 */

-(void)signOnWithIdentityToken:(NSString*)identityToken :(BOOL)isTestAccount;{
    /**
     *  check network connectivity
     */
    if ([self CheckNetworConnectivity]==YES) {
NSString *appendedString=[identityToken stringByAppendingString:@" : "];
NSData *tokenData = [appendedString dataUsingEncoding:NSUTF8StringEncoding];
NSString * stringBase64 = [tokenData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];

NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];

NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
        NSURL * url;
        if (isTestAccount)
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@SvcInfo/token",kServer_Test_Url]];
        else
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@SvcInfo/token",kServer_Url]];

NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];

[urlRequest setHTTPMethod:NSLocalizedString(@"GET", nil)];

[urlRequest addValue:NSLocalizedString(@"application/json",nil) forHTTPHeaderField:NSLocalizedString(@"Accept",nil)];
[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
[urlRequest setValue:[NSString stringWithFormat:@"Basic %@",stringBase64] forHTTPHeaderField:kAuthorization];
 
NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  
                                  {
                                    NSString *responseStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      if(error==nil && responseStr.length>0)
                                      {
                                          if(self.delegate != nil && ([self.delegate conformsToProtocol:@protocol(VelocityProcessorSignOnDelegate)]))
                                          {
                                              
                                                  [self.delegate performSelector:@selector(VelocityProcessorSignOnServerRequestFinishedWithSuccess:) withObject:responseStr];
                                          }
                                      }
                                      else
                                      {
                                          [self.delegate performSelector:@selector(VelocityProcessorSignOnServerRequestFailedWithErrorMessage:) withObject:@"Server Error"];
                                      }
                                  }];
[dataTask resume];
    }
    /**
     *  if Network fails
     */
    else{
        [self.delegate performSelector:@selector(VelocityProcessorSignOnServerRequestFailedWithErrorMessage:) withObject:@"Network Error!!"];
    }
}

/*!
 *  @author sumit suman, 15-01-23 18:01:05
 *
 *  @brief  ssl verification

 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler{
     completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}

@end
