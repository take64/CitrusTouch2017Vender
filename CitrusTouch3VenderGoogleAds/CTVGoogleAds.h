//
//  CTVGoogleAds.h
//  CitrusTouch3
//
//  Created by take64 on 2017/03/28.
//  Copyright © 2017年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <GoogleMobileAds/GoogleMobileAds.h>

@interface CTVGoogleAds : NSObject
{
    
    // 広告ユニットID
    NSString *adUnitID;
    
    // 広告リスト
    NSMutableDictionary *bannerStacks;
}

//
// property
//
@property (nonatomic, retain) NSString *adUnitID;
@property (nonatomic, retain) NSMutableDictionary *bannerStacks;


//
// method
//


// バナー広告生成
- (GADBannerView *)addBannerID:(NSString *)bannerID size:(CGSize)bannerSize rootController:(UIViewController *)rootController;

// バナー広告取得
- (GADBannerView *)callBannerID:(NSString *)bannerID;

// バナー広告生成・取得
- (GADBannerView *)callBannerWithSection:(NSInteger)section rootController:(UIViewController<GADBannerViewDelegate> *)rootController;

// setup
- (void)setupAdUnitID:(NSString *)_adUnitID;

// singleton
+ (instancetype)sharedService;

@end
