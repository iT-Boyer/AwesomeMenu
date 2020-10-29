//
//  AwesomeMenuWindow.m
//  AwesomeMenu
//
//  Created by jhmac on 2020/10/29.
//

#import "AwesomeMenuWindow.h"

@interface AwesomeMenuWindow()
@property (nonatomic, strong) UIButton *entryBtn;
@property (nonatomic, assign) CGFloat kEntryViewSize;
@property (nonatomic) CGPoint startingPosition;
@end

@implementation AwesomeMenuWindow

-(instancetype)initWithStartPoint:(CGPoint)startingPosition{
   self.startingPosition = startingPosition;
   _kEntryViewSize = 58;
   CGFloat x = self.startingPosition.x;
   CGFloat y = self.startingPosition.y;
   CGPoint defaultPosition = AwesomeMenuStartingPosition;
   if (x < 0 || x > (AwesomeMenuScreenWidth - _kEntryViewSize)) {
       x = defaultPosition.x;
   }
   
   if (y < 0 || y > (AwesomeMenuScreenHeight - _kEntryViewSize)) {
       y = defaultPosition.y;
   }
   
   self = [super initWithFrame:CGRectMake(x, y, _kEntryViewSize, _kEntryViewSize)];
   if (self) {
       #if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
           if (@available(iOS 13.0, *)) {
               UIScene *scene = [[UIApplication sharedApplication].connectedScenes anyObject];
               if (scene) {
                   self.windowScene = (UIWindowScene *)scene;
               }
           }
       #endif
       self.backgroundColor = [UIColor clearColor];
       self.windowLevel = UIWindowLevelStatusBar + 100.f;
       self.layer.masksToBounds = YES;
       NSString *version= [UIDevice currentDevice].systemVersion;
       if(version.doubleValue >=10.0) {
           if (!self.rootViewController) {
               self.rootViewController = [[UIViewController alloc] init];
           }
       }else{
           //iOS9.0的系统中，新建的window设置的rootViewController默认没有显示状态栏
           if (!self.rootViewController) {
//               self.rootViewController = [[AwesomeMenuStatusBarViewController alloc] init];
           }
       }
       
       [self.rootViewController.view addSubview:self.entryBtn];
       UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
       [self addGestureRecognizer:pan];
   }
   return self;
}

- (void)show{
   self.hidden = NO;
}

- (void)showClose:(NSNotification *)notification{
//   [_entryBtn setImage:[UIImage AwesomeMenu_imageNamed:@"AwesomeMenu_close"] forState:UIControlStateNormal];
   [_entryBtn removeTarget:self action:@selector(showClose:) forControlEvents:UIControlEventTouchUpInside];
   [_entryBtn addTarget:self action:@selector(closePluginClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)closePluginClick:(UIButton *)btn{
//   [_entryBtn setImage:[UIImage AwesomeMenu_imageNamed:@"AwesomeMenu_logo"] forState:UIControlStateNormal];
   [_entryBtn removeTarget:self action:@selector(closePluginClick:) forControlEvents:UIControlEventTouchUpInside];
   [_entryBtn addTarget:self action:@selector(entryClick:) forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark - getter
- (UIButton *)entryBtn {
    if (!_entryBtn) {
        _entryBtn = [[UIButton alloc] initWithFrame:self.bounds];
        _entryBtn.backgroundColor = [UIColor clearColor];
//        UIImage *image = [UIImage AwesomeMenu_imageNamed:@"AwesomeMenu_logo"];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        if (@available(iOS 13.0, *)) {
            if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
//                image = [UIImage AwesomeMenu_imageNamed:@"AwesomeMenu_logo_dark"];
            }
        }
#endif
//        [_entryBtn setImage:image forState:UIControlStateNormal];
        _entryBtn.layer.cornerRadius = 20.;
        [_entryBtn addTarget:self action:@selector(entryClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    return _entryBtn;
}

@end
