//
//  UIView+DZ.m
//  de.dreimannzelt.addition.ios
//
//  Created by Jan Weinkauff on 03.01.11.
//  Copyright 2011 Dreimannzelt. All rights reserved.
//

#import "UIView+DZ.h"


@implementation UIView (DZ)

#pragma mark -
#pragma mark Dimension attributes

- (CGSize)size {
	return self.frame.size;
}

- (void)setSize:(CGSize)size {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.x, size.width, size.height);
}

- (CGPoint)origin {
	return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
	self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (CGFloat)x {
	return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
	self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)y {
	return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
	self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

#pragma mark -
#pragma mark Alignment

- (void)alignCenterToCenterOfSuperviewAnimated:(BOOL)animated {
	if (!self.superview)
		return;
	CGPoint newCenter = CGPointMake(self.superview.width / 2.0f, self.superview.height / 2.0f);
	if (animated)
		[UIView animateWithDuration:0.5f animations:^{
			self.center = newCenter;
		}];
	else 
		self.center = newCenter;
}

- (void)alignCenterHorizontalToSuperviewAnimated:(BOOL)animated {
	if (!self.superview)
		return;
	CGPoint newCenter = CGPointMake(self.superview.width / 2.0f, self.center.y);
	if (animated)
		[UIView animateWithDuration:0.5f animations:^{
			self.center = newCenter;
		}];
	else 
		self.center = newCenter;	
}

- (void)alignCenterVerticalToSuperviewAnimated:(BOOL)animated {
	if (!self.superview)
		return;
	CGPoint newCenter = CGPointMake(self.center.x, self.superview.height / 2.0f);
	if (animated)
		[UIView animateWithDuration:0.5f animations:^{
			self.center = newCenter;
		}];
	else 
		self.center = newCenter;		
}

#pragma mark -
#pragma mark Query

- (UIView *)subviewWhichSatisfy:(BOOL (^) (UIView *))block {
	for (UIView *aView in self.subviews)
		if (block(aView)) return aView;
	return nil;
}

- (NSArray *)subviewsWhichSatisfy:(BOOL (^) (UIView *))block {
    NSMutableArray* views = [NSMutableArray array];
	for (UIView *aView in self.subviews)
		if (block(aView))
            [views addObject:aView];
	return views;
}

- (UIView *)subviewOfAllSubviewsWhichSatisfy:(BOOL (^) (UIView *))block {
	for (UIView *aView in self.subviews)
		if (block(aView)) return aView;
	for (UIView *aView in self.subviews)
		return [aView subviewOfAllSubviewsWhichSatisfy:block];
	return nil;
}

- (NSArray *)subviewsOfAllSubviewsWhichSatisfy:(BOOL (^) (UIView *))block {
    NSMutableArray* views = [NSMutableArray array];
	for (UIView *aView in self.subviews)
		if (block(aView)) [views addObject:aView];
	for (UIView *aView in self.subviews)
		[views addObjectsFromArray:[aView subviewsOfAllSubviewsWhichSatisfy:block]];
	return views;
}

@end
