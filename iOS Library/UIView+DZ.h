//
//  UIView+DZ.h
//  DMZ iOS Library
//
//  Created by Jan Weinkauff on 03.01.11.
//  Copyright 2011 Dreimannzelt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIView (DZ)

// Extended dimension attributes (based on frame)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

// Positioning
- (void)alignCenterToCenterOfSuperviewAnimated:(BOOL)animated;
- (void)alignCenterHorizontalToSuperviewAnimated:(BOOL)animated;
- (void)alignCenterVerticalToSuperviewAnimated:(BOOL)animated;
- (void)alignCenterVerticalWithHeight:(CGFloat)height animated:(BOOL)animated;

// Query
- (UIView *)subviewWhichSatisfy:(BOOL (^) (UIView *))block;
- (NSArray *)subviewsWhichSatisfy:(BOOL (^) (UIView *))block;
- (UIView *)subviewOfAllSubviewsWhichSatisfy:(BOOL (^) (UIView *))block;
- (NSArray *)subviewsOfAllSubviewsWhichSatisfy:(BOOL (^) (UIView *))block;

// Animation
- (void)animateRightBounce;
- (void)animateLeftBounce;
- (void)animateBottomBounce;
- (void)animateTopBounce;

- (void)fadeInWithDuration:(NSTimeInterval)duration;
- (void)fadeOutWithDuration:(NSTimeInterval)duration;

@end
