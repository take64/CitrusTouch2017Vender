//
//  CTVGoogleAds.m
//  CitrusTouch3
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import "CTVGoogleAds.h"


@implementation CTVGoogleAds

//
// synthesize
//
@synthesize adUnitID;
@synthesize bannerStacks;



#pragma mark - method
//
// method
//


// バナー広告生成
- (GADBannerView *)addBannerID:(NSString *)bannerID size:(CGSize)bannerSize rootController:(UIViewController *)rootController
{
    // 取得
    GADBannerView *bannerView = [self callBannerID:bannerID];
    if(bannerView == nil)
    {
        // 生成
        bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 0, bannerSize.width, bannerSize.height)];
        [bannerView setAdUnitID:[self adUnitID]];
        [[self bannerStacks] setObject:bannerView forKey:bannerID];
        
        // コントローラー設定
        [bannerView setRootViewController:rootController];
    }
    return bannerView;
}

// バナー広告取得
- (GADBannerView *)callBannerID:(NSString *)bannerID
{
    if([self bannerStacks] == nil)
    {
        [self setBannerStacks:[@{} mutableCopy]];
    }
    
    return [[self bannerStacks] objectForKey:bannerID];
}

// バナー広告生成・取得
- (GADBannerView *)callBannerWithSection:(NSInteger)section rootController:(UIViewController<GADBannerViewDelegate> *)rootController
{
    // バナーIDの生成
    NSString *bannerID = CTStringf(@"%@_banner_%d", NSStringFromClass([rootController class]), @"320x50", section);
    
    // ビュー取得
    GADBannerView *bannerView = [self callBannerID:bannerID];
    if(bannerView == nil)
    {
        // 生成
        bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
        [bannerView setAdUnitID:[self adUnitID]];
        [bannerView setDelegate:rootController];
        [bannerView setRootViewController:rootController];
        [bannerView loadRequest:[GADRequest request]];
        
        // スタック
        [[self bannerStacks] setObject:bannerView forKey:bannerID];
    }
    
    return bannerView;
}

// setup
- (void)setupAdUnitID:(NSString *)_adUnitID;
{
    [[CTVGoogleAds sharedService] setAdUnitID:_adUnitID];
}


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
