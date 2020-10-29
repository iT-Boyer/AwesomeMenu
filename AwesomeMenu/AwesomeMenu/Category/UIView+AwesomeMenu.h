//
//  UIView+AwesomeMenu.h
//  AwesomeMenuKit
//
//  Created by xgb on 2018/11/15.
//

#import <UIKit/UIKit.h>

@interface UIView (AwesomeMenu)

/** View's X Position */
@property (nonatomic, assign) CGFloat   awesomeMenu_x;

/** View's Y Position */
@property (nonatomic, assign) CGFloat   awesomeMenu_y;

/** View's width */
@property (nonatomic, assign) CGFloat   awesomeMenu_width;

/** View's height */
@property (nonatomic, assign) CGFloat   awesomeMenu_height;

/** View's origin - Sets X and Y Positions */
@property (nonatomic, assign) CGPoint   awesomeMenu_origin;

/** View's size - Sets Width and Height */
@property (nonatomic, assign) CGSize    awesomeMenu_size;

/** Y value representing the bottom of the view **/
@property (nonatomic, assign) CGFloat   awesomeMenu_bottom;

/** X Value representing the right side of the view **/
@property (nonatomic, assign) CGFloat   awesomeMenu_right;

/** X Value representing the top of the view (alias of x) **/
@property (nonatomic, assign) CGFloat   awesomeMenu_left;

/** Y Value representing the top of the view (alias of y) **/
@property (nonatomic, assign) CGFloat   awesomeMenu_top;

/** X value of the object's center **/
@property (nonatomic, assign) CGFloat   awesomeMenu_centerX;

/** Y value of the object's center **/
@property (nonatomic, assign) CGFloat   awesomeMenu_centerY;

- (UIViewController*)viewController;

@end

