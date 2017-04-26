//
//  CTVDropbox.h
//  CitrusTouch2017
//
//  Created by take64 on 2017/04/01.
//  Copyright © 2017年 citrus.live. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>

@interface CTVDropbox : NSObject
{
    // app key
    NSString *appKey;
}

//
// property
//
@property (nonatomic, retain) NSString *appKey;

// セットアップ
- (void)setupAppKey:(NSString *)_appKey;

// 認証
- (void)authorizeFromController:(UIViewController *)fromController;

// 認証済み？
- (BOOL)isAuthorized;

// 認証解除
- (void)unlink;

// call client
- (DBUserClient *)callClient;

// upload data
- (void)uploadData:(NSData *)datafile filename:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock;

// download data
- (void)downloadData:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock;

// delete data
- (void)deleteData:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock;

//// put data
//- (void)putData:(NSData *)datafile filename:(NSString *)filename progress:(CitrusTouchProgressBlock)progressBlock complete:(CitrusTouchProgressBlock)completeBlock;


// singleton
+ (instancetype)sharedService;

@end
