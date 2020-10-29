//
//  UIViewController+AwesomeMenu.m
//  AwesomeMenu
//
//  Created by jhmac on 2020/10/29.
//

#import "UIViewController+AwesomeMenu.h"
#import "UIView+AwesomeMenu.h"
#import "AwesomeMenuHomeWindow.h"

@implementation UIViewController (AwesomeMenu)

- (UIEdgeInsets)safeAreaInset:(UIView *)view {
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

// safe area inset
- (UIEdgeInsets)safeAreaInset {
    return [self safeAreaInset:self.view];
}

// 默认采用view frame | 调整刘海屏 | 支持转向调整
- (CGRect) fullscreen {
    CGRect screen = self.view.frame;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            CGSize size = self.view.awesomeMenu_size;
            if (size.width > size.height) {
                UIEdgeInsets safeAreaInsets = [self safeAreaInset];
                CGRect frame = screen;
                CGFloat width = self.view.awesomeMenu_width - safeAreaInsets.left - safeAreaInsets.right;
                frame.origin.x = safeAreaInsets.left;
                frame.size.width = width;
                screen = frame;
            }
        }
            break;
        default:
            screen = screen;
            break;
    }
    
    return screen;
}

+ (UIViewController *)rootViewControllerForKeyWindow{
    UIWindow *keyWindow = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        keyWindow = [[UIApplication sharedApplication].delegate window];
    }else{
        keyWindow = [UIApplication sharedApplication].windows.firstObject;
    }
    
    return [keyWindow rootViewController];
}

+ (UIViewController *)topViewControllerForKeyWindow {
    UIViewController *resultVC;
    UIWindow *keyWindow = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        keyWindow = [[UIApplication sharedApplication].delegate window];
    }else{
        keyWindow = [UIApplication sharedApplication].windows.firstObject;
    }
    resultVC = [self _topViewController:[keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (UIViewController *)rootViewControllerForDoraemonHomeWindow{
    return [AwesomeMenuHomeWindow shareInstance].rootViewController;
}
@end
