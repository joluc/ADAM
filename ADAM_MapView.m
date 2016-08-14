//
//  ADAM_MapView.m
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import "ADAM_MapView.h"
#import "MBProgressHUD.h"
#import "ViewDownInterface.h"

BOOL updated;
BOOL loadedonce;
ViewDownInterface *interface;
MKCoordinateRegion oldregion;

@implementation ADAM_MapView 
-(void)setup
{
    loadedonce = NO;
    
    updated = YES;
    BOOL userl;
    BOOL stuttgart;
    stuttgart = NO;
    interface = [[ViewDownInterface alloc]initWithFrame:CGRectMake(0, self.frame.size.height-self.frame.size.height/10, self.frame.size.width, self.frame.size.height/10)];
    interface.bonjour = _fromage;
    userl = YES;
    
    [interface setup];
    interface.mapviewadam = (id)self;
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = (id)self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    if (userl)
    {
    _map.showsUserLocation = YES;
    }
    
    
    _map = [[MKMapView alloc]initWithFrame:self.frame];
    [_map setMapType:MKMapTypeStandard];
    
    [_map setZoomEnabled:YES];
    [_map setScrollEnabled:YES];
    [_map setPitchEnabled:YES];
    
    _map.delegate = (id)self;
    if (userl)
    {
    _map.showsUserLocation = YES;
    }
    
    
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
    
    for (NSObject *coordinate2 in geos)
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
        if ([point.title isEqualToString:(@"ELEVATOR")])
        {
            NSString *creator;
            creator = [NSString stringWithFormat:@"%d",drei];
            
            point.title = (@"Aufzug bei Station: ");
            point.title = [point.title stringByAppendingString:creator];
        }
        if ([point.title isEqualToString:(@"ESCALATOR")])
        {
            NSString *creator;
            creator = [NSString stringWithFormat:@"%d",drei];
            point.title = (@"Rolltreppe bei Station: ");
            point.title = [point.title stringByAppendingString:creator];
            
        }
//        NSLog(@"%@",point.subtitle);
        
        
        [self.map addAnnotation:point];
        drei++;
    }
    
    if (stuttgart)
    {
    [self setstuttgart];
    }
    self.map.alpha = 0.1;
    [self addSubview:interface];
    interface.hidden = YES;
    self.map.showsBuildings = YES;
    
}


-(void)setstuttgart
{
//    48.7758° N, 9.1829° E
    
    
    NSString *location = @"Arnulf-Klett-Platz 2, Germany, 70173";
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         
                         MKCoordinateRegion region = self.map.region;
                         
                         region.center = placemark.region.center;
                         region.span.longitudeDelta /= 5.8;
                         region.span.latitudeDelta /= 5.8;
                         MBProgressHUD * hud =  [MBProgressHUD showHUDAddedTo:self.viewc.view animated:YES];
                         hud.detailsLabel.text = (@"Region: Stuttgart");
                         
                         [MKMapView animateWithDuration:1.5 animations:^{
                             [self.map setRegion:region animated:YES];
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:1.0 animations:^{
                                 [MBProgressHUD HUDForView:self.viewc.view];
                                 
                             }];
                         }];
                     }
                     if (error)
                     {
                         NSLog(@"%@",error.localizedDescription);
                     }
                 }
     ];
    
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
    if (!loadedonce)
    {
    loadedonce = YES;
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         self.viewc.imageviewback.transform = CGAffineTransformMakeScale(2, 2);
         MBProgressHUD *hud;
         hud = [MBProgressHUD HUDForView:self.viewc.view];
         hud.detailsLabel.text = (@"Fast fertig!");
         
         self.map.alpha = 0.1;
         self.map.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
         self.viewc.imageviewback.hidden = YES;
         [MBProgressHUD hideHUDForView:_viewc.view animated:YES];
     }];
    }
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    self.viewc.datenschutz.hidden = YES;
    [interface loadforID:[[view annotation] subtitle]];
    
//    MKCoordinateRegion region;
//    region.center = [[view annotation] coordinate];
//    MKCoordinateSpan span;
//    span.latitudeDelta = 0.15;
//    span.longitudeDelta = 0.15;
//    mapView.camera.pitch = 45;
//    [mapView setRegion:region animated:YES];
    
    oldregion = mapView.region;
    
    MKMapCamera *newCamera=[[MKMapCamera alloc] init];
    
    //set a new camera angle
    [newCamera setCenterCoordinate:CLLocationCoordinate2DMake([[view annotation]coordinate].latitude,[[view annotation]coordinate].longitude)];
    
    [newCamera setPitch:60.0];
    [newCamera setAltitude:100.0];
    [mapView setCamera:newCamera animated:YES];
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(nonnull MKAnnotationView *)view
{
    self.viewc.datenschutz.hidden = NO;
    [mapView setRegion:oldregion animated:YES];
    
    [interface sethiddennow];
}
-(void)comeinfrombottom:(UIView*)button
{
    CGRect oldframe = button.frame;
    CGRect newframe = CGRectMake(0, self.frame.size.height+button.frame.size.height, button.frame.size.width, button.frame.size.height);
    button.frame = newframe;
    
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         button.frame = oldframe;
     }
                     completion:^(BOOL finished)
     {
         printf("\n Completed");
         
     }];
    
}

@end



