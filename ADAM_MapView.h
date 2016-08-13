//
//  ADAM_MapView.h
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ADAMerci.h"
#import "ViewController.h"


@interface ADAM_MapView : UIView <MKMapViewDelegate>

@property NSMutableArray *coords;
@property ADAMerci *fromage;
@property MKMapView *map;
@property ViewController *viewc;
@property(nonatomic, retain) CLLocationManager *locationManager;

-(void)setup;

@end
