//
//  UIColor+AwesomeMenu.h
//  AwesomeMenuKit
//
//  Created by yixiang on 2017/12/11.
//

#import <UIKit/UIKit.h>

@interface UIColor (AwesomeMenu)

@property (nonatomic, readonly) CGFloat red; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat green; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat blue; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat white; // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
@property (nonatomic, readonly) CGFloat alpha;


+ (UIColor *)awesomeMenu_colorWithHex:(UInt32)hex;
+ (UIColor *)awesomeMenu_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)awesomeMenu_colorWithHexString:(NSString *)hexString;

+ (UIColor *)awesomeMenu_colorWithString:(NSString *)hexString;

+ (UIColor *)awesomeMenu_black_1;//#333333
+ (UIColor *)awesomeMenu_black_2;//#666666
+ (UIColor *)awesomeMenu_black_3;//#999999

+ (UIColor *)awesomeMenu_blue;//#337CC4

+ (UIColor *)awesomeMenu_line;//[UIColor awesomeMenu_colorWithHex:0x000000 andAlpha:0.1];

+ (UIColor *)awesomeMenu_randomColor;

+ (UIColor *)awesomeMenu_bg; //#F4F5F6

+ (UIColor *)awesomeMenu_orange; //#FF8903

@end
