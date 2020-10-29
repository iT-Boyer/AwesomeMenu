//
//  AwesomeMenuManager.m
//  AwesomeMenu
//
//  Created by jhmac on 2020/10/29.
//

#import "AwesomeMenuManager.h"
#import "AwesomeMenuDefine.h"
#import "AwesomeMenuUtil.h"
#import "AwesomeMenuHomeWindow.h"
#import "AwesomeMenuWindow.h"

@interface AwesomeMenuManager()
@property (nonatomic, strong) AwesomeMenuWindow *entryWindow;

@property (nonatomic, assign) BOOL hasInstall;
// 定制位置
@property (nonatomic) CGPoint startingPosition;
@end

@implementation AwesomeMenuManager

+ (nonnull AwesomeMenuManager *)shareInstance{
    static dispatch_once_t once;
    static AwesomeMenuManager *instance;
    dispatch_once(&once, ^{
        instance = [[AwesomeMenuManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _autoDock = YES;
//        _keyBlockDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)install{
    //启用默认位置
    CGPoint defaultPosition = AwesomeMenuStartingPosition;
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (size.width > size.height) {
        defaultPosition = AwesomeMenuFullScreenStartingPosition;
    }
    [self installWithStartingPosition:defaultPosition delegate:nil];
}

- (void)installWithStartingPosition:(CGPoint) position delegate:(id<AwesomeMenuDelegate>)delegate
{
    _startingPosition = position;
    self.delegate = delegate;
    [self installWithCustomBlock:^{
        //什么也没发生
    }];
}

- (void)installWithCustomBlock:(void(^)(void))customBlock{
    //保证install只执行一次
    if (_hasInstall) {
        return;
    }
    _hasInstall = YES;
//    for (int i=0; i<_startPlugins.count; i++) {
//        NSString *pluginName = _startPlugins[i];
//        Class pluginClass = NSClassFromString(pluginName);
//        id<DoraemonStartPluginProtocol> plugin = [[pluginClass alloc] init];
//        if (plugin) {
//            [plugin startPluginDidLoad];
//        }
//    }

//    [self initData];
    customBlock();

    [self initEntry:self.startingPosition];
}
/**
 初始化工具入口
 */
- (void)initEntry:(CGPoint) startingPosition{
    _entryWindow = [[AwesomeMenuWindow alloc] initWithStartPoint:startingPosition];
    [_entryWindow show];
    if(_autoDock){
        [_entryWindow setAutoDock:YES];
    }
}

- (BOOL)isShowAwesomeMenu{
    if (!_entryWindow) {
        return NO;
    }
    return !_entryWindow.hidden;
}

- (void)showAwesomeMenu{
    if (_entryWindow.hidden) {
        _entryWindow.hidden = NO;
    }
}

- (void)hiddenAwesomeMenu{
    if (!_entryWindow.hidden) {
        _entryWindow.hidden = YES;
     }
}
@end
