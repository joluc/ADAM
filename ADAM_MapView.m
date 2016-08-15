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
#import "outrepasser.h"

BOOL updated;
BOOL loadedonce;
ViewDownInterface *interface;
MKCoordinateRegion oldregion;
UIImage *redelevator;
UIImage *greenelevator;

@implementation ADAM_MapView 
-(void)setup
{
    redelevator = [self imageWithImage:[UIImage imageNamed:@"elevatorinactive.png"] scaledToSize:CGSizeMake(8, 8)]; // Ich dachte, wenn ich die Bilder einmal so speichere kann ich sie effizienter aufrufen....
    greenelevator = [self imageWithImage:[UIImage imageNamed:@"elevatoractive.png"] scaledToSize:CGSizeMake(8, 8)]; // same
   
    // Irgendwelche Kontrolldinger
    loadedonce = NO;
    updated = YES;
    BOOL userl;
    // Ende Kontrolldinger
    
    /// Hier ist der "Stuttgart-Modus"
    BOOL stuttgart;
    stuttgart = NO;
    
    ///Das Interface wird eingeblendet, wenn man eine Annotation anklickt. Oh, das muss ich auch noch kommentieren -.-
    interface = [[ViewDownInterface alloc]initWithFrame:CGRectMake(0, self.frame.size.height-self.frame.size.height/7, self.frame.size.width, self.frame.size.height/7)];
    interface.bonjour = _fromage;
    userl = YES;
    
    
    [interface setup]; // Mal wieder was setupen... Ist das eigentlich ein Wort? Ich glaube irgendwie nicht
    interface.mapviewadam = (id)self;
    
    // Location Manager! Warum initaliziere ich den eigentlich zwei mal?!
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = (id)self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    if (userl)
    {
    _map.showsUserLocation = YES;
    }
    
    // Hier kommt das Ding was so viel Speicher zieht
    _map = [[MKMapView alloc]initWithFrame:self.frame]; // DIE MAP!
    [_map setMapType:MKMapTypeStandard];
    
    [_map setZoomEnabled:YES];
    [_map setScrollEnabled:YES];
    [_map setPitchEnabled:YES];
    
    _map.delegate = (id)self;
    if (userl)
    {
    _map.showsUserLocation = YES; // Jaja, du bist echt toll
    }
    
    
    [self addSubview:_map];
    NSMutableArray *geos = [_fromage coords]; // Jetzt die Koordinatenaufbereitung vorbereiten
    
    int drei;
    drei = 0; // Übrigens, die counter heißen bei mir fast immer irgendwas mit drei ^^
    
    for (NSObject *coordinate2 in geos) // eine for schleife um die latitude und die longitude in ein
    {
        NSMutableDictionary *dictico;
        dictico = [_fromage dicforindex:drei];
        
        CLLocationCoordinate2D coordinate = [[geos objectAtIndex:drei] MKCoordinateValue];
//        NSLog(@"%f",coordinate.latitude);
//        NSLog(@"%f",coordinate.longitude);
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coordinate;
        NSString *ident;
//        ident = [dictico objectForKey:(@"equipmentnumber")]; // Hat nicht funktioniert, weißte
        ident = [NSString stringWithFormat:@"%@",[dictico objectForKey:(@"equipmentnumber")]];
        
//        NSLog(@"LONG %@",ident);
        
        point.subtitle = ident; // Das ist echt viel wichtiger als es aussieht! Über diesen SUbtitle erkenne ich nämlich was ich dem Punkt zuweisen muss - von Bildern bis zu Beschreibungen und Koordinaten
        
        
//        NSLog(@"%@",dictico.description);
        
        
        
        point.title = [_fromage.type objectAtIndex:drei]; // Titel setzen
        
        // Übersetzen
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
        
        // Und den ganzen Spaß hinzufügen!
        [self.map addAnnotation:point];
        drei++;
    }
    
    // Stuttgart "Modus"
    if (stuttgart)
    {
    [self setstuttgart];
    }
    
    
    self.map.alpha = 0.0; // Wegen Animation die gleich kommt...
    [self addSubview:interface]; // Das Interface hinzufügen
    interface.hidden = YES;
    self.map.showsBuildings = YES;
    
    NSLog(@"%lu Objekte geladen.",(unsigned long)[_fromage.description_ count]); // Kleiner Log
//    AIzaSyAfN0znfkVve3HM5itywturlxOpF2Rl9FA // Das hier einfach ignorieren ^^
    
}

///Stuttgart Modus
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
    if (!updated) // Einmal hinzoomen reicht!!
    {
    [_map setRegion:[_map regionThatFits:region] animated:YES];
    updated = YES;
    }
    
}
///Spaß mit Annotationen
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    //Erstmal schauen ob das der Userstandort ist
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        
        return nil;
    }
    // jetzt kommt das wahrscheinlich am uneffizientesten programmierte im ganzen Code!
    else if ([annotation isKindOfClass:[MKPointAnnotation class]]) // use whatever annotation class you used when creating the annotation
    {
        NSString *identifier = [NSString stringWithFormat:@"An%d",(int)[annotation subtitle]];
//        NSLog(@"%@",identifier);
        
        MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier]; // Gibts das nicht schon?
        
        if (annotationView)
        {
            return annotationView; // Mal zurückgeben. Hat schon existiert
        }
        
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:identifier]; // Hier muss ich es leider erstmal erstellen
        
        NSString *identi;
        identi = [[annotationView annotation] subtitle]; // Jetzt seht ihr gleich warum das so wichtig ist
        NSString *status;
        NSString *typee;
        typee = [self.fromage typeforquipmentnumber:identi]; // Unfassbar umständlich, ich weiß. Aber es klappt!!
//        NSLog(@"ASKING FOR %@",identi);
        
        
        status = [self.fromage statusforquipmentnumber:identi]; // Hier gehts auch noch
        
//        NSLog(@"ID: %@",identi);
        
//        NSLog(@"Status: %@",status);
        
        //Jetzt noch das Bildlein setzen
        if ([typee isEqualToString:(@"ESCALATOR")]) //Rolltreppe
        {
            annotationView.image = [UIImage imageNamed:@"costumann.png"];
            
        if ([status isEqualToString:(@"ACTIVE")])
        {
        
            annotationView.image = [UIImage imageNamed:@"greenann.png"];
        }
            
        }
        if ([typee isEqualToString:(@"ELEVATOR")]) // und Aufzug
        {
        annotationView.image = redelevator;
        if ([status isEqualToString:(@"ACTIVE")])
        {
        annotationView.image = greenelevator;
        }
        }
        
        annotationView.canShowCallout = YES;
        
        
        // Und das ganze schön langsam einblenden, dann fällt es nicht auf wie kacke das eigentlich reinploppt
        [UIView animateWithDuration:0.5
                              delay:0.2
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             annotationView.alpha = 0.0;
             annotationView.alpha = 1.0;
         }
                         completion:^(BOOL finished)
         {
             
         }];
        
        return annotationView; // Dann noch zurückgeben!
    }
    return nil;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize { // Bild verkleinern, sonst ist das zu groß
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered // Wenn die Map geladen wurde wird das hier aufgerufen
{
    if (!loadedonce) // Das hier lädt nur einmal!
    {
        
    loadedonce = YES;
        // Die Animation wird nach dem Laden der Map ausgeführt, eigentlich ganz cool
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
         self.viewc.imageviewback = nil;
         
         [MBProgressHUD hideHUDForView:_viewc.view animated:YES]; // Und natürlich das HUD verstecken, sind ja mit dem Groben fertig
     }];
    }
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view // Das wird aufgerufen wenn man auf eine Annotation klickst
{
    // Dann blende ich erstmal die Credits aus
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         self.viewc.credits.alpha = 1.0;
         self.viewc.credits.alpha = 0.0;
     }
                     completion:^(BOOL finished)
     {
         
     }];
    self.viewc.datenschutz.hidden = YES;
    [interface loadforID:[[view annotation] subtitle]]; // Und lade das mit dem Subtitle ( von dem wird man noch öfter hören )
    
    oldregion = mapView.region; // ich merke mir die Region, dass ich wieder an die Stelle springen kann wo der Nutzer vor dem Klick war
    
    MKMapCamera *newCamera=[[MKMapCamera alloc] init]; // Neue Camera für Animation mit Pitch
    
    //set a new camera angle
    [newCamera setCenterCoordinate:CLLocationCoordinate2DMake([[view annotation]coordinate].latitude,[[view annotation]coordinate].longitude)];
    
    [newCamera setPitch:60.0];
    [newCamera setAltitude:100.0];
    [mapView setCamera:newCamera animated:YES]; // Mal hinfliegen
    
    // Hier wird das Bild von Google Streetview zu dem Ortsnamen geladen. Werde ich nicht erklären, ist selbsterklärend
    NSString *longi;
    NSString *lati;
    
    
    CLLocationCoordinate2D point;
    point = [[view annotation] coordinate];
    
    longi = [[NSNumber numberWithDouble:point.longitude] stringValue];
    lati = [[NSNumber numberWithDouble:point.latitude] stringValue];
    
    
    //    7.590019933
    //    50.358767133
    //    AIzaSyAfN0znfkVve3HM5itywturlxOpF2Rl9FA KEY
    //    https://maps.googleapis.com/maps/api/streetview?size=600x300&location=46.414382,10.013988&heading=151.78&pitch=-0.76&key=
    NSString *urlmaker;
    
    urlmaker = (@"https://maps.googleapis.com/maps/api/streetview?size=500x200&location=");
    
//    urlmaker = [urlmaker stringByAppendingString:lati];
//    urlmaker = [urlmaker stringByAppendingString:(@",")];
//    urlmaker = [urlmaker stringByAppendingString:longi];
    NSString *locii;
    locii = [nummerbahnnow valueForKey:[[view annotation] subtitle]];
    locii = [locii stringByReplacingOccurrencesOfString:(@" Hbf") withString:(@"")];
    
    urlmaker = [urlmaker stringByAppendingString:locii];
    
    urlmaker = [urlmaker stringByAppendingString:(@"&key=")];
    urlmaker = [urlmaker stringByAppendingString:(@"AIzaSyAfN0znfkVve3HM5itywturlxOpF2Rl9FA")];
    NSString *urlmaked = [urlmaker stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [interface setimageurl:urlmaked];
    //Fertig!
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(nonnull MKAnnotationView *)view // Wird beim deselecten der Annotation aufgerufen
{
    self.viewc.datenschutz.hidden = NO; // Datenschutz unhidden
    // Und jetzt reinanimieren... uuui
    [UIView animateWithDuration:1.4
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         [mapView setRegion:oldregion animated:YES];
         self.viewc.credits.alpha = 0.0;
         self.viewc.credits.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
         
     }];
    
    [interface sethiddennow]; // Das wird noch erklärt
}
/// Das musste ich vorerst weglassen
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



