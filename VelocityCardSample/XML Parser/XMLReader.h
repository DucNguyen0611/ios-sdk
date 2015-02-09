//
//  XMLReader.h
//  XMLReader
//
//  Created by shahab on 11/06/12.
//  Copyright (c) 2012 Agnity. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMLReader : NSObject
{
    NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
    NSError *errorPointer;
    NSDictionary* parentDictionary;
}

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;

@end
