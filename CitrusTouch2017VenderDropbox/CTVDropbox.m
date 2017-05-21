//
//  CTVDropbox.m
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/01.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTVDropbox.h"

#import <ObjectiveDropboxOfficial/DBFILESWriteMode.h>

#import "CTProgress.h"

@implementation CTVDropbox

//
// synthesize
//
@synthesize appKey;

#pragma mark - method
//
// method
//

// セットアップ
- (void)setupAppKey:(NSString *)_appKey
{
    [self setAppKey:_appKey];
    [DBClientsManager setupWithAppKey:_appKey];
}

// 認証
- (void)authorizeFromController:(UIViewController *)fromController
{
    [DBClientsManager authorizeFromController:[UIApplication sharedApplication] controller:fromController openURL:^(NSURL *url) {
        [[UIApplication sharedApplication] openURL:url];
    } browserAuth:YES];
}


// 認証済み？
- (BOOL)isAuthorized
{
//    return ([DBClientsManager authorizedClient] == nil ? NO : YES );
    return [[DBClientsManager authorizedClient] isAuthorized];
}

// 認証解除
- (void)unlink
{
    [DBClientsManager unlinkAndResetClients];
}

// call client
- (DBUserClient *)callClient
{
    return [DBClientsManager authorizedClient];
}

// upload data
- (void)uploadData:(NSData *)datafile filename:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock;
{
    // client
    DBUserClient *client = [[CTVDropbox sharedService] callClient];
    
    // name
    filename = [NSString stringWithFormat:@"/%@", filename];
    
    // upload
    [[[[client filesRoutes] uploadData:filename mode:[[DBFILESWriteMode alloc] initWithOverwrite] autorename:@YES clientModified:[NSDate date] mute:@NO inputData:datafile] setResponseBlock:^(DBFILESFileMetadata * _Nullable result, DBFILESUploadError * _Nullable routeError, DBRequestError * _Nullable networkError) {
        CTProgress *progress = [CTProgress complete];
        completeBlock(progress, nil);
        
        CTLog(@"%@", networkError);
        
    }] setProgressBlock:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
        CTProgress *progress = [CTProgress progressing:@(bytesWritten) total:@(totalBytesWritten)];
        
        progressBlock(progress, nil);
    }];
}

// download data
- (void)downloadData:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock;
{
    // client
    DBUserClient *client = [[CTVDropbox sharedService] callClient];
    
    // name
    filename = [NSString stringWithFormat:@"/%@", filename];
    
    [[[[client filesRoutes] downloadData:filename] setResponseBlock:^(DBFILESFileMetadata * _Nullable result, DBFILESDownloadError * _Nullable routeError, DBRequestError * _Nullable networkError, NSData * _Nullable fileData) {
        
        CTProgress *progress = [[CTProgress alloc] initWithResultData:fileData];
        completeBlock(progress, nil);
        
        CTLog(@"%@", networkError);
        
    }] setProgressBlock:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
        CTProgress *progress = [[CTProgress alloc] initWithProgressing:@(bytesWritten) total:@(totalBytesWritten)];
        progressBlock(progress, nil);
    }];
}

// delete data
- (void)deleteData:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock
{
    // client
    DBUserClient *client = [[CTVDropbox sharedService] callClient];
    
    // name
    filename = [NSString stringWithFormat:@"/%@", filename];
    
    [[[[client filesRoutes] delete_:filename] setResponseBlock:^(DBFILESMetadata * _Nullable result, DBFILESDeleteError * _Nullable routeError, DBRequestError * _Nullable networkError) {
        
        CTProgress *progress = [CTProgress complete];
        completeBlock(progress, nil);
        
        CTLog(@"%@", networkError);
        
    }] setProgressBlock:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
        CTProgress *progress = [[CTProgress alloc] initWithProgressing:@(bytesWritten) total:@(totalBytesWritten)];
        progressBlock(progress, nil);
    }];
}

//// put data
//- (void)putData:(NSData *)datafile filename:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock
//{
//    [self deleteData:filename progress:^(CTProgress *progress, NSError *error) {
//        
//    } complete:^(CTProgress *progress, NSError *error) {
//        
//        [self uploadData:datafile filename:filename progress:^(CTProgress *progress, NSError *error) {
//            
//            completeBlock(progress, nil);
//            
//        } complete:^(CTProgress *progress, NSError *error) {
//            
//            progressBlock(progress, nil);
//            
//        }];
//        
//    }];
//}


#pragma mark - singleton
// singleton
+ (instancetype)sharedService
{
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[[self class] alloc] init];
    });
    return singleton;
}

@end
