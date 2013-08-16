//
//  BGQuickStuff.h
//  MyiTunes
//
//  Created by Brendan Gunning on 18/05/2012.
//  Copyright (c) 2012 www.gunningfor.me All rights reserved.
//


#import <UIKit/UIKit.h>

@interface BGQuickStuff : NSObject

// Directory handling
+ (NSString *)dataFileLocation;
+ (NSString *)documentsDirectory;
+ (void)moveFileToDocumentsDirectory:(NSString *)filename;
+ (BOOL)doesFileExist:(NSString *)path;
+ (void)createDirectory:(NSString *)directoryName atFilePath:(NSString *)filePath;
+ (void)deleteFileAtPath:(NSString *)path;

// Quick preference access and setting
+ (NSString *)prefValueForKey:(NSString *)key;
+ (void)setPrefForKey:(NSString *)key withValue:(NSString *)value;

// Device details
+ (NSString *)deviceModel;
+ (NSString *)deviceOsVersion;

// Application details
+ (NSString *)appVersion;

@end