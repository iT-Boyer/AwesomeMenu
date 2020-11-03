//
//  AppDelegate+Awesome.m
//  JHUniversalApp
//
//  Created by jhmac on 2020/11/3.
//  Copyright © 2020  William Sterling. All rights reserved.
//

#import "AppDelegate+Awesome.h"
//#import "MNFloatBtn.h"
#import "AwesomeMenu.h"
#import "AwesomeMenuManager.h"

@interface AppDelegate(Awesome)<AwesomeMenuDelegate>

@end


@implementation AppDelegate (Awesome)


-(void)awesomePlugs
{
    [[AwesomeMenuManager shareInstance] installWithStartingPosition:CGPointMake(0,300) delegate:self];
}

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
    
}
- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
}


@end
