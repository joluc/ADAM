//
//  JFMapView.h
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 24.02.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "GridTileOverlay.h"


@interface JFMapView : MKMapView <UIScrollViewDelegate>
@property GridTileOverlay *gridOverlay;
@end
