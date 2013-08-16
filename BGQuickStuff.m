//
//  BGQuickStuff.m
//  MyMedia
//
//  Created by Bren Gunning on 15/05/2012.
//  Copyright (c) 2012 www.gunningfor.me All rights reserved.
//

#import "BGQuickStuff.h"

@implementation BGQuickStuff

// Directory handling
+ (NSString *)dataFileLocation {
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentDBFolderPath = [documentsDirectory stringByAppendingPathComponent:@"test.json"];
    success = [fileManager fileExistsAtPath:documentDBFolderPath];
    
    if (success == NO){
        
        NSString *resourceDBFolderPath = [[[NSBundle mainBundle] resourcePath]
                                          stringByAppendingPathComponent:@"test.json"];
        //[fileManager createDirectoryAtPath: documentDBFolderPath attributes:nil];
        [fileManager copyItemAtPath:resourceDBFolderPath toPath:documentDBFolderPath
                              error:&error];
    }
    
    NSLog(@"%@", documentDBFolderPath);
    return documentDBFolderPath;
    
}
+ (NSString *)documentsDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
    
}
+ (void)moveFileToDocumentsDirectory:(NSString *)filename {
    
    NSLog(@"Filename is: %@", filename);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *origFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
    NSString *docsFilePath = [documentsDirectory stringByAppendingPathComponent:filename];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:docsFilePath]) {
        
        NSLog(@"File exists!");
        
    } else {
        
        NSError *error = nil;
        BOOL success = [[NSFileManager defaultManager] copyItemAtPath:origFilePath toPath:docsFilePath error:&error];
        
        if (!success) {
            NSLog(@"Error in copying was: %@", [error description]);
        }
        
    }
}
+ (BOOL)doesFileExist:(NSString *)path {
    
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
    
}
+(void)createDirectory:(NSString *)directoryName atFilePath:(NSString *)filePath
{
    NSString *filePathAndDirectory = [filePath stringByAppendingPathComponent:directoryName];
    NSError *error;
    
    if (![[NSFileManager defaultManager] createDirectoryAtPath:filePathAndDirectory
                                   withIntermediateDirectories:NO
                                                    attributes:nil
                                                         error:&error])
    {
        NSLog(@"Create directory error: %@", error);
    }
}
+ (void)deleteFileAtPath:(NSString *)path {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:path error:nil];
    
}

// Quick preference stuff
+ (NSString *)prefValueForKey:(NSString *)key {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    return [prefs objectForKey:key];
    
}
+ (void)setPrefForKey:(NSString *)key withValue:(NSString *)value {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:value forKey:key];
    [prefs synchronize];
}


// Device details
+ (NSString *)deviceModel {
    UIDevice *currentDevice = [UIDevice currentDevice];
    return [currentDevice model];
}
+ (NSString *)deviceOsVersion {
    UIDevice *currentDevice = [UIDevice currentDevice];
    return [currentDevice systemVersion];
}

// Application details
+ (NSString *)appVersion {
    return [[NSBundle mainBundle]
     objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
}

@end

