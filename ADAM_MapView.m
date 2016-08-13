//
//  ADAM_MapView.m
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import "ADAM_MapView.h"
#import "MBProgressHUD.h"

BOOL updated;

@implementation ADAM_MapView 
-(void)setup
{
    updated = NO;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = (id)self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    _map.showsUserLocation = YES;
    [_map setMapType:MKMapTypeStandard];
    [_map setZoomEnabled:YES];
    [_map setScrollEnabled:YES];
    _map = [[MKMapView alloc]initWithFrame:self.frame];
    _map.delegate = (id)self;
    _map.showsUserLocation = YES;
    
    
    [self addSubview:_map];
    NSMutableArray *geos = [_fromage coords];
    
//    for(NSDictionary* postLocateDict in mapData ) {
//        double lat = [[postLocateDict objectForKey:@"location_dx"] doubleValue];
//        double longt = [[postLocateDict objectForKey:@"location_dy"] doubleValue];
//        CLLocationCoordinate2D loc;
//        loc.longitude = longt;
//        loc.latitude = lat;
//        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
//        annotationPoint.coordinate = loc;
//        [mapViewHuanBao addAnnotation:annotationPoint];
//        annotationTag++;
//    }
    
    int drei;
    drei = 0;
    
    for (NSObject *coordinate in geos)
    {
        NSMutableDictionary *dictico;
        dictico = [_fromage dicforindex:drei];
        
        CLLocationCoordinate2D coordinate = [[geos objectAtIndex:drei] MKCoordinateValue];
//        NSLog(@"%f",coordinate.latitude);
//        NSLog(@"%f",coordinate.longitude);
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coordinate;
        NSString *ident;
//        ident = [dictico objectForKey:(@"equipmentnumber")];
        ident = [NSString stringWithFormat:@"%@",[dictico objectForKey:(@"equipmentnumber")]];
        
        
        
//        NSLog(@"LONG %@",ident);
        
        point.subtitle = ident;
        
        
//        NSLog(@"%@",dictico.description);
        
        point.title = [_fromage.type objectAtIndex:drei];
        
//        NSLog(@"%@",point.subtitle);
        
        
        [self.map addAnnotation:point];
        drei++;
    }
    
    
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    if (!updated)
    {
    [_map setRegion:[_map regionThatFits:region] animated:YES];
    updated = YES;
    }
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        
        return nil;
    }
    else if ([annotation isKindOfClass:[MKPointAnnotation class]]) // use whatever annotation class you used when creating the annotation
    {
        static NSString * const identifier = @"MyCustomAnnotation";
        
        MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        
        
        if (annotationView)
        {
            annotationView.annotation = annotation;
        }
        else
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:identifier];
        }
        NSString *identi;
        identi = [[annotationView annotation] subtitle];
        NSString *status;
        NSString *typee;
        typee = [self.fromage typeforquipmentnumber:identi];
//        NSLog(@"ASKING FOR %@",identi);
        
        
        status = [self.fromage statusforquipmentnumber:identi];
        
//        NSLog(@"ID: %@",identi);
        
//        NSLog(@"Status: %@",status);
        if ([typee isEqualToString:(@"ESCALATOR")])
        {
            
        annotationView.image = [UIImage imageNamed:@"costumann.png"];
            
        if ([status isEqualToString:(@"ACTIVE")])
        {
                annotationView.image = [UIImage imageNamed:@"greenann.png"];
        }
            
        }
        if ([typee isEqualToString:(@"ELEVATOR")])
        {
        annotationView.image = [UIImage imageNamed:@"costumann.png"];
        
        if ([status isEqualToString:(@"ACTIVE")])
        {
        annotationView.image = [UIImage imageNamed:@"greenann.png"];
        }
        }
        
        annotationView.canShowCallout = YES;
        
        return annotationView;
    }
    return nil;
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    [MBProgressHUD hideHUDForView:_viewc.view animated:YES];
    
    
}
//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
//{
//    [mapView deselectAnnotation:view.annotation animated:YES];
//    
//    printf("\n Selecting");
//    
//}

@end