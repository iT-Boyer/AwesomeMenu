//
//  AwesomeMenuHomeWindow.m
//  AwesomeMenuKit-AwesomeMenuKit
//
//  Created by yixiang on 2018/5/16.
//

#import "AwesomeMenuHomeWindow.h"
#import "AwesomeMenuDefine.h"
#import "UIColor+AwesomeMenu.h"
//#import "AwesomeMenuHomeViewController.h"

@interface AwesomeMenuHomeWindow()

- (void)openPlugin:(UIViewController *)vc;

@end

@implementation AwesomeMenuHomeWindow

+ (AwesomeMenuHomeWindow *)shareInstance{
    static dispatch_once_t once;
    static AwesomeMenuHomeWindow *instance;
    dispatch_once(&once, ^{
        instance = [[AwesomeMenuHomeWindow alloc] initWithFrame:CGRectMake(0, 0, AwesomeMenuScreenWidth, AwesomeMenuScreenHeight)];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelStatusBar - 1.f;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        #if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
            if (@available(iOS 13.0, *)) {
                for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes){
                    if (windowScene.activationState == UISceneActivationStateForegroundActive){
                        self.windowScene = windowScene;
                        break;
                    }
                }
            }
        #endif
    }
    return self;
}

- (void)openPlugin:(UIViewController *)vc{
    [self setRootVc:vc];
     self.hidden = NO;
}

- (void)show{
//    AwesomeMenuHomeViewController *vc = [[AwesomeMenuHomeViewController alloc] init];
//    [self setRootVc:vc];
    
    self.hidden = NO;
}

- (void)hide{
    if (self.rootViewController.presentedViewController) {
        [self.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    [self setRootVc:nil];
    
    self.hidden = YES;
}

- (void)setRootVc:(UIViewController *)rootVc{
    if (rootVc) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVc];
        NSDictionary *attributesDic = @{
                                        NSForegroundColorAttributeName:[UIColor blackColor],
                                        NSFontAttributeName:[UIFont systemFontOfSize:18]
                                        };
        [nav.navigationBar setTitleTextAttributes:attributesDic];
        _nav = nav;
        
        self.rootViewController = nav;
    }else{
        self.rootViewController = nil;
        _nav = nil;
    }

}

+ (void)openPlugin:(UIViewController *)vc{
    [[self shareInstance] openPlugin:vc];
}

@end
