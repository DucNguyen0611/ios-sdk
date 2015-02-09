//
//  VelocityProcessorSignOn.h
//  VelocityCardSample
//
//  Created by Chetu on 21/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol VelocityProcessorSignOnDelegate<NSObject>
@required
-(void)VelocityProcessorSignOnServerRequestFinishedWithSuccess:(NSString *)successSessionToken;
-(void)VelocityProcessorSignOnServerRequestFailedWithErrorMessage:(NSString *)failed;
@end

@interface VelocityProcessorSignOn :NSObject<NSURLSessionTaskDelegate,NSURLSessionDownloadDelegate,NSURLSessionDelegate,NSURLSessionDataDelegate>
{
  NSMutableData *responseData;
    
}

@property (nonatomic, strong) id <VelocityProcessorSignOnDelegate> delegate;


-(id)initServer;
-(void)signOnWithIdentityToken:(NSString*)identityToken :(BOOL)isTestAccount;

@end
