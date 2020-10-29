//
//  AwesomeMenuManager.h
//  AwesomeMenu
//
//  Created by jhmac on 2020/10/29.
//

#import <Foundation/Foundation.h>
#import "AwesomeMenu.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AwesomeMenuDelegate;

@interface AwesomeMenuManager : NSObject

+ (nonnull AwesomeMenuManager *)shareInstance;

@property (nonatomic, weak) id<AwesomeMenuDelegate> delegate;

@property (nonatomic, assign) BOOL autoDock; //dokit entry icon support autoDock，deffault yes

- (void)install;

//带有平台端功能的s初始化方式
- (void)installWithPid:(NSString *)pId;

// 定制起始位置 | 适用正好挡住关键位置
- (void)installWithStartingPosition:(CGPoint) position;

- (void)installWithCustomBlock:(void(^)(void))customBlock;


- (BOOL)isShowAwesomeMenu;

- (void)showAwesomeMenu;

- (void)hiddenAwesomeMenu;

- (void)hiddenHomeWindow;
@end

NS_ASSUME_NONNULL_END
