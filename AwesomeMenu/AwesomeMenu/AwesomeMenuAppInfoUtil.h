//
//  AwesomeMenuAppInfoUtil.h
//  AwesomeMenu
//
//  Created by jhmac on 2020/10/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AwesomeMenuAppInfoUtil : NSObject
+ (NSString *)appName;

/**
 DeviceInfo：获取当前设备的 用户自定义的别名，例如：库克的 iPhone 9
 
 @return 当前设备的 用户自定义的别名，例如：库克的 iPhone 9
 */
+ (NSString *)iphoneName;

/**
 DeviceInfo：获取当前设备的 系统名称，例如：iOS 13.1
 
 @return 当前设备的 系统名称，例如：iOS 13.1
 */
+ (NSString *)iphoneSystemVersion;

+ (NSString *)bundleIdentifier;

+ (NSString *)bundleVersion;

+ (NSString *)bundleShortVersionString;

+ (NSString *)iphoneType;

+ (BOOL)isIPhoneXSeries;

+ (BOOL)isIpad;

+ (NSString *)locationAuthority;

+ (NSString *)pushAuthority;

+ (NSString *)cameraAuthority;

+ (NSString *)audioAuthority;

+ (NSString *)photoAuthority;

+ (NSString *)addressAuthority;

+ (NSString *)calendarAuthority;

+ (NSString *)remindAuthority;

+ (NSString *)bluetoothAuthority;

/// 设备是否模拟器
+ (BOOL)isSimulator;

//获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
@end


NS_ASSUME_NONNULL_END
