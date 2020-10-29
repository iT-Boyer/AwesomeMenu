//
//  AwesomeMenuDefine.h
//  AwesomeMenuKitDemo
//
//  Created by yixiang on 2017/12/11.
//  Copyright © 2017年 yixiang. All rights reserved.
//

#ifndef AwesomeMenuDefine_h
#define AwesomeMenuDefine_h

#import "AwesomeMenuAppInfoUtil.h"
#import "UIColor+AwesomeMenu.h"
//#import "UIView+AwesomeMenu.h"
//#import "UIImage+AwesomeMenu.h"
//#import "AwesomeMenui18NUtil.h"
//#import "AwesomeMenuToastUtil.h"
//#import "AwesomeMenuAlertUtil.h"
#import "AwesomeMenuUtil.h"

#define DoKitVersion @"3.0.2"
#define DoKitKbChange(x) x * 1000

//#define DoKit_OpenLog

#ifdef DoKit_OpenLog
#define DoKitLog(...) NSLog(@"DoKitLog -> %s\n %@ \n\n",__func__,[NSString stringWithFormat:__VA_ARGS__]);
#else
#define DoKitLog(...)
#endif

#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define AwesomeMenuScreenWidth [UIScreen mainScreen].bounds.size.width
#define AwesomeMenuScreenHeight [UIScreen mainScreen].bounds.size.height

//AwesomeMenu默认位置
#define AwesomeMenuStartingPosition            CGPointMake(0, AwesomeMenuScreenHeight/3.0)

//AwesomeMenu全屏默认位置
#define AwesomeMenuFullScreenStartingPosition  CGPointZero

//根据750*1334分辨率计算size
#define kAwesomeMenuSizeFrom750(x) ((x)*AwesomeMenuScreenWidth/750)
// 如果横屏显示
#define kAwesomeMenuSizeFrom750_Landscape(x) (kInterfaceOrientationPortrait ? kAwesomeMenuSizeFrom750(x) : ((x)*AwesomeMenuScreenHeight/750))

#define kInterfaceOrientationPortrait UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)


#define IS_IPHONE_X_Series [AwesomeMenuAppInfoUtil isIPhoneXSeries]
#define IPHONE_NAVIGATIONBAR_HEIGHT  (IS_IPHONE_X_Series ? 88 : 64)
#define IPHONE_STATUSBAR_HEIGHT      (IS_IPHONE_X_Series ? 44 : 20)
#define IPHONE_SAFEBOTTOMAREA_HEIGHT (IS_IPHONE_X_Series ? 34 : 0)
#define IPHONE_TOPSENSOR_HEIGHT      (IS_IPHONE_X_Series ? 32 : 0)

//判空
#define STRING_IS_BLANK(str) (str==nil ||![str isKindOfClass:[NSString class]]|| [str length]<1)
#define STRING_NOT_NULL(str) ((str==nil)?@"":str)
#define DICTIONARY_IS_EMPTY(dic) ((dic)==nil || ![(dic) isKindOfClass:[NSDictionary class]] || (dic).count < 1)
#define ARRAY_IS_NULL(array) ((array)==nil || ![(array) isKindOfClass:[NSArray class]] || ([array count]) < 1)
#define ARRAY_IS_EMPTY(array) ((array)==nil || ![(array) isKindOfClass:[NSArray class]] || (array).count < 1)
#define STRING_DEFAULT_BLANK(str) ((str==nil)?@"":str)


#define AwesomeMenuClosePluginNotification @"AwesomeMenuClosePluginNotification"
#define AwesomeMenuQuickOpenLogVCNotification @"AwesomeMenuQuickOpenLogVCNotification"
#define AwesomeMenuKitManagerUpdateNotification @"AwesomeMenuKitManagerUpdateNotification"


#endif /* AwesomeMenuDefine_h */
