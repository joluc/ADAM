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
#import "JFMapView.h"
#import "FSRotatingCamera.h"
#import <FBClusteringManager.h>

#import "WatermarkTileOverlayRenderer.h"
#if ( OFFLINE_USE_CUSTOM_OVERLAY_RENDERER == 1)
#import "GridTileOverlayRenderer.h"
#endif


// TILE
typedef NS_ENUM(NSInteger, CustomMapTileOverlayType) {
    CustomMapTileOverlayTypeApple = 0,
    CustomMapTileOverlayTypeOpenStreet = 1,
    CustomMapTileOverlayTypeGoogle = 2,
    CustomMapTileOverlayTypeOffline = 3
};



///Ganz wichtiges Ding. Da ist das Interfacezeug drauf
@interface ADAM_MapView : UIView <MKMapViewDelegate>


@property NSMutableArray *coords;
@property ADAMerci *fromage;
@property JFMapView *map;
@property ViewController *viewc;
@property(nonatomic, retain) CLLocationManager *locationManager; // Ich hasse dich
@property FBClusteringManager *clusteringManager;


//TILE
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *overlaySelector;
@property (strong, nonatomic) MKTileOverlay *tileOverlay;
@property (strong, nonatomic) MKTileOverlay *gridOverlay;

@property (assign, nonatomic) CustomMapTileOverlayType overlayType;


//FSROT

@property (nonatomic, strong) FSRotatingCamera *rotCamera;
@property (nonatomic, assign) BOOL rotating;

-(void)setup;

@end
