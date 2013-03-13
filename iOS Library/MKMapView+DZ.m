//
//  MKMapView+DZ.m
//  DMZ-iOS-Library
//
//  Created by Jörg Polakowski on 13/03/13.
//  Copyright (c) 2013 Dreimannzelt. All rights reserved.
//

#import "MKMapView+DZ.h"

@implementation MKMapView (DZ)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated {

    MKCoordinateSpan span = MKCoordinateSpanMake(0, 360 / pow(2, zoomLevel) * self.frame.size.width / 256);
    [self setRegion:MKCoordinateRegionMake(centerCoordinate, span) animated:animated];
}

@end
