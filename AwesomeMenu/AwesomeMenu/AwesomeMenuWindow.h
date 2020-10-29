//
//  AwesomeMenuWindow.h
//  AwesomeMenu
//
//  Created by jhmac on 2020/10/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 入口滑动浮窗（默认记录上次坐标）
@interface AwesomeMenuWindow : UIWindow
/// 是否自动停靠，默认为YES
@property (nonatomic, assign) BOOL autoDock;

// 定制位置
- (instancetype)initWithStartPoint:(CGPoint)startingPosition;
- (void)show;

@end

NS_ASSUME_NONNULL_END
