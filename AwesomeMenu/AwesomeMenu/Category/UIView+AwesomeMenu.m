//
//  UIView+AwesomeMenuPositioning.m
//  AwesomeMenuKit
//
//  Created by xgb on 2018/11/15.
//

#import "UIView+AwesomeMenu.h"

#define AwesomeMenu_SCREEN_SCALE                    ([[UIScreen mainScreen] scale])
#define AwesomeMenu_PIXEL_INTEGRAL(pointValue)      (round(pointValue * AwesomeMenu_SCREEN_SCALE) / AwesomeMenu_SCREEN_SCALE)

@implementation UIView (AwesomeMenu)

@dynamic awesomeMenu_x, awesomeMenu_y, awesomeMenu_width, awesomeMenu_height, awesomeMenu_origin, awesomeMenu_size;

// Setters
-(void)setAwesomeMenu_x:(CGFloat)x{
    self.frame      = CGRectMake(AwesomeMenu_PIXEL_INTEGRAL(x), self.awesomeMenu_y, self.awesomeMenu_width, self.awesomeMenu_height);
}

-(void)setAwesomeMenu_y:(CGFloat)y{
    self.frame      = CGRectMake(self.awesomeMenu_x, AwesomeMenu_PIXEL_INTEGRAL(y), self.awesomeMenu_width, self.awesomeMenu_height);
}

-(void)setAwesomeMenu_width:(CGFloat)width{
    self.frame      = CGRectMake(self.awesomeMenu_x, self.awesomeMenu_y, AwesomeMenu_PIXEL_INTEGRAL(width), self.awesomeMenu_height);
}

-(void)setAwesomeMenu_height:(CGFloat)height{
    self.frame      = CGRectMake(self.awesomeMenu_x, self.awesomeMenu_y, self.awesomeMenu_width, AwesomeMenu_PIXEL_INTEGRAL(height));
}

-(void)setAwesomeMenu_origin:(CGPoint)origin{
    self.awesomeMenu_x          = origin.x;
    self.awesomeMenu_y          = origin.y;
}

-(void)setAwesomeMenu_size:(CGSize)size{
    self.awesomeMenu_width      = size.width;
    self.awesomeMenu_height     = size.height;
}

-(void)setAwesomeMenu_right:(CGFloat)right {
    self.awesomeMenu_x          = right - self.awesomeMenu_width;
}

-(void)setAwesomeMenu_bottom:(CGFloat)bottom {
    self.awesomeMenu_y          = bottom - self.awesomeMenu_height;
}

-(void)setAwesomeMenu_left:(CGFloat)left{
    self.awesomeMenu_x          = left;
}

-(void)setAwesomeMenu_top:(CGFloat)top{
    self.awesomeMenu_y          = top;
}

-(void)setAwesomeMenu_centerX:(CGFloat)centerX {
    self.center     = CGPointMake(AwesomeMenu_PIXEL_INTEGRAL(centerX), self.center.y);
}

-(void)setAwesomeMenu_centerY:(CGFloat)centerY {
    self.center     = CGPointMake(self.center.x, AwesomeMenu_PIXEL_INTEGRAL(centerY));
}

// Getters
-(CGFloat)awesomeMenu_x{
    return self.frame.origin.x;
}

-(CGFloat)awesomeMenu_y{
    return self.frame.origin.y;
}

-(CGFloat)awesomeMenu_width{
    return self.frame.size.width;
}

-(CGFloat)awesomeMenu_height{
    return self.frame.size.height;
}

-(CGPoint)awesomeMenu_origin{
    return CGPointMake(self.awesomeMenu_x, self.awesomeMenu_y);
}

-(CGSize)awesomeMenu_size{
    return CGSizeMake(self.awesomeMenu_width, self.awesomeMenu_height);
}

-(CGFloat)awesomeMenu_right {
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)awesomeMenu_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)awesomeMenu_left{
    return self.awesomeMenu_x;
}

-(CGFloat)awesomeMenu_top{
    return self.awesomeMenu_y;
}

-(CGFloat)awesomeMenu_centerX {
    return self.center.x;
}

-(CGFloat)awesomeMenu_centerY {
    return self.center.y;
}

-(UIViewController*)viewController{
    for(UIView *next =self.superview ; next ; next = next.superview){
        UIResponder*nextResponder = [next nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]]){
            return(UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
