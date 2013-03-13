//
//  MKMapView+DZ.h
//  DMZ-iOS-Library
//
//  Created by Jörg Polakowski on 13/03/13.
//  Copyright (c) 2013 Dreimannzelt. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (DZ)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

@end
