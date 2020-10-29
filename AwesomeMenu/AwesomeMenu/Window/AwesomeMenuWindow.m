//
//  AwesomeMenuWindow.m
//  AwesomeMenu
//
//  Created by jhmac on 2020/10/29.
//

#import "AwesomeMenuWindow.h"
#import "AwesomeMenuHomeWindow.h"
#import "UIView+AwesomeMenu.h"
#import "UIImage+AwesomeMenu.h"

#import "AwesomeMenuManager.h"
#import "AwesomeMenu.h"

@interface AwesomeMenuWindow()
@property (nonatomic, strong) UIButton *entryBtn;
@property (nonatomic, assign) CGFloat kEntryViewSize;
@property (nonatomic) CGPoint startingPosition;


@property (strong, nonatomic) AwesomeMenu *menu;
@end

@implementation AwesomeMenuWindow

-(instancetype)initWithStartPoint:(CGPoint)startingPosition{
   self.startingPosition = startingPosition;
   _kEntryViewSize = 100;
   CGFloat x = self.startingPosition.x;
   CGFloat y = self.startingPosition.y;
   CGPoint defaultPosition = AwesomeMenuStartingPosition;
   if (x < 0 || x > (AwesomeMenuScreenWidth - _kEntryViewSize)) {
       x = defaultPosition.x;
   }
   
   if (y < 0 || y > (AwesomeMenuScreenHeight - _kEntryViewSize)) {
       y = defaultPosition.y;
   }
   
//   self = [super initWithFrame:CGRectMake(x, y, _kEntryViewSize, _kEntryViewSize)];
   self = [super initWithFrame:[UIScreen mainScreen].bounds];
   self.menu.startPoint = CGPointMake(x, y);
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
       
       [self.rootViewController.view addSubview:self.menu];
       UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
       [self addGestureRecognizer:pan];
   }
   return self;
}

- (void)show{
   self.hidden = NO;
}

- (void)showClose:(NSNotification *)notification{
   [_entryBtn setImage:[UIImage awesomeMenu_imageNamed:@"awesomeMenu_close"] forState:UIControlStateNormal];
   [_entryBtn removeTarget:self action:@selector(showClose:) forControlEvents:UIControlEventTouchUpInside];
   [_entryBtn addTarget:self action:@selector(closePluginClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)closePluginClick:(UIButton *)btn{
   [_entryBtn setImage:[UIImage awesomeMenu_imageNamed:@"awesomeMenu_logo"] forState:UIControlStateNormal];
   [_entryBtn removeTarget:self action:@selector(closePluginClick:) forControlEvents:UIControlEventTouchUpInside];
   [_entryBtn addTarget:self action:@selector(entryClick:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 进入工具主面板
 */
- (void)entryClick:(UIButton *)btn{
    if ([AwesomeMenuHomeWindow shareInstance].hidden) {
        [[AwesomeMenuHomeWindow shareInstance] show];
//        DoKitBP(@"dokit_sdk_home_ck_entry")
    }else{
        [[AwesomeMenuHomeWindow shareInstance] hide];
    }
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    return;
    if (self.autoDock) {
        [self autoDocking:pan];
    }else{
        [self normalMode:pan];
    }
}

- (void)normalMode: (UIPanGestureRecognizer *)panGestureRecognizer{
    //1、获得拖动位移
    CGPoint offsetPoint = [panGestureRecognizer translationInView:panGestureRecognizer.view];
    //2、清空拖动位移
    [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
    //3、重新设置控件位置
    UIView *panView = panGestureRecognizer.view;
    CGFloat newX = panView.awesomeMenu_centerX+offsetPoint.x;
    CGFloat newY = panView.awesomeMenu_centerY+offsetPoint.y;
    if (newX < _kEntryViewSize/2) {
        newX = _kEntryViewSize/2;
    }
    if (newX > AwesomeMenuScreenWidth - _kEntryViewSize/2) {
        newX = AwesomeMenuScreenWidth - _kEntryViewSize/2;
    }
    if (newY < _kEntryViewSize/2) {
        newY = _kEntryViewSize/2;
    }
    if (newY > AwesomeMenuScreenHeight - _kEntryViewSize/2) {
        newY = AwesomeMenuScreenHeight - _kEntryViewSize/2;
    }
    panView.center = CGPointMake(newX, newY);
}

- (void)autoDocking:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIView *panView = panGestureRecognizer.view;
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [panGestureRecognizer translationInView:panView];
            [panGestureRecognizer setTranslation:CGPointZero inView:panView];
            panView.center = CGPointMake(panView.center.x + translation.x, panView.center.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            CGPoint location = panView.center;
            CGFloat centerX;
            CGFloat safeBottom = 0;
            if (@available(iOS 11.0, *)) {
               safeBottom = self.safeAreaInsets.bottom;
            }
            CGFloat centerY = MAX(MIN(location.y, CGRectGetMaxY([UIScreen mainScreen].bounds)-safeBottom), [UIApplication sharedApplication].statusBarFrame.size.height);
            if(location.x > CGRectGetWidth([UIScreen mainScreen].bounds)/2.f)
            {
                centerX = CGRectGetWidth([UIScreen mainScreen].bounds)-_kEntryViewSize/2;
            }
            else
            {
                centerX = _kEntryViewSize/2;
            }
            [[NSUserDefaults standardUserDefaults] setObject:@{
                                                               @"x":[NSNumber numberWithFloat:centerX],
                                                               @"y":[NSNumber numberWithFloat:centerY]
                                                               } forKey:@"FloatViewCenterLocation"];
            [UIView animateWithDuration:0.3 animations:^{
                panView.center = CGPointMake(centerX, centerY);
            }];
        }

        default:
            break;
    }
}

#pragma mark - getter
- (UIButton *)entryBtn {
    if (!_entryBtn) {
        _entryBtn = [[UIButton alloc] initWithFrame:self.bounds];
        _entryBtn.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage awesomeMenu_imageNamed:@"awesomeMenu_logo"];
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
        if (@available(iOS 13.0, *)) {
            if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                image = [UIImage awesomeMenu_imageNamed:@"awesomeMenu_logo_dark"];
            }
        }
#endif
        [_entryBtn setImage:image forState:UIControlStateNormal];
        _entryBtn.layer.cornerRadius = 20.;
        [_entryBtn addTarget:self action:@selector(entryClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    return _entryBtn;
}

-(AwesomeMenu *)menu
{
    if (!_menu) {
        UIImage *storyMenuItemImage = [UIImage imageNamed:@"AwesomeMenu.bundle/bg-menuitem.png"];
        UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"AwesomeMenu.bundle/bg-menuitem-highlighted.png"];
        UIImage *starImage = [UIImage imageNamed:@"AwesomeMenu.bundle/icon-star.png"];
        
        AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                              highlightedImage:storyMenuItemImagePressed
                                                                  ContentImage:starImage
                                                       highlightedContentImage:nil];
       AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                              highlightedImage:storyMenuItemImagePressed
                                                                  ContentImage:starImage
                                                       highlightedContentImage:nil];
       AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                              highlightedImage:storyMenuItemImagePressed
                                                                  ContentImage:starImage
                                                       highlightedContentImage:nil];
       AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                              highlightedImage:storyMenuItemImagePressed
                                                                  ContentImage:starImage
                                                       highlightedContentImage:nil];
       AwesomeMenuItem *starMenuItem5 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                              highlightedImage:storyMenuItemImagePressed
                                                                  ContentImage:starImage
                                                       highlightedContentImage:nil];
        
        NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5, nil];
       
       AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"AwesomeMenu.bundle/bg-addbutton.png"]
                                                          highlightedImage:[UIImage imageNamed:@"AwesomeMenu.bundle/bg-addbutton-highlighted.png"]
                                                              ContentImage:[UIImage imageNamed:@"AwesomeMenu.bundle/icon-plus.png"]
                                                   highlightedContentImage:[UIImage imageNamed:@"AwesomeMenu.bundle/icon-plus-highlighted.png"]];
       
       _menu = [[AwesomeMenu alloc] initWithFrame:self.bounds startItem:startItem optionMenus:menus];
       _menu.delegate = [AwesomeMenuManager shareInstance].delegate;
       
       _menu.menuWholeAngle = M_PI_2;
        _menu.farRadius = 110.0f;
        _menu.endRadius = 100.0f;
        _menu.nearRadius = 90.0f;
        _menu.animationDuration = 0.3f;
    }
    return _menu;
}


@end
