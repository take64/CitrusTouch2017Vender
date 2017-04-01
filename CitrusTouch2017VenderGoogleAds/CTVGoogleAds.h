//
//  CTVGoogleAds.h
//  HanayuAccountBookPod
//
//  Created by kouhei.takemoto on 2017/03/28.
//  Copyright © 2017年 citrus.live. All rights reserved.
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

// setup
+ (void)setupAdUnitID:(NSString *)_adUnitID;

// singleton
+ (instancetype)sharedService;

@end
