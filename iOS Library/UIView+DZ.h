//
//  UIView+DZ.h
//  de.dreimannzelt.addition.ios
//
//  Created by Jan Weinkauff on 03.01.11.
//  Copyright 2011 Dreimannzelt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIView (DZ)

// Extended dimension attributes
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

// Query
- (UIView *)subviewWhichSatisfy:(BOOL (^) (UIView *))block;
- (NSArray *)subviewsWhichSatisfy:(BOOL (^) (UIView *))block;
- (UIView *)subviewOfAllSubviewsWhichSatisfy:(BOOL (^) (UIView *))block;
- (NSArray *)subviewsOfAllSubviewsWhichSatisfy:(BOOL (^) (UIView *))block;

@end
