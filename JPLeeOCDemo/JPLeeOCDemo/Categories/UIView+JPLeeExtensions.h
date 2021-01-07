//
//  UIView+JPLeeExtensions.h
//  JPLeeOCDemo
//
//  Created by Admin on 2021/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (JPLeeExtensions)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

- (void)removeAllSubviews;
- (UIViewController *)viewController;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

/// 设置完frame后裁剪，裁剪后无法更新，这种方式节省性能
- (void)circleShap;
- (void)drawCircleRadius:(CGFloat)cornerRadius;
- (void)drawCircleCornerRadii:(CGSize)cornerRadii byRoundingCorners:(UIRectCorner)corners;

@end

NS_ASSUME_NONNULL_END
