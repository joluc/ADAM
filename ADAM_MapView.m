
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
#import "ADAMAnnotation.h"
#import "MarqueeLabel.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "WildcardGestureRecognizer.h"
#import <FBClusteringManager.h>
#import "FSRotatingCamera.h"

#define MERCATOR_RADIUS 85445659.44705395
#define MAX_GOOGLE_LEVELS 20



BOOL clusterZoom;
BOOL updated;
BOOL loadedonce;
BOOL _modifyingMap;
BOOL selected_point;


ViewDownInterface *interface;
MKCoordinateRegion oldregion;
MKCoordinateRegion startregion;
NSString *USE_TILE;


UIImage *redelevator;
UIImage *bredelevator;
UIImage *greenelevator;
UIImage *bgreenelevator;
UIButton *back_camera;


NSMutableArray *points; // ALL PINS

@implementation ADAM_MapView

-(void)setup
{
    USE_TILE = (@"NO");
    // TILE BENUTZEN - DEFAULT NO
    
    bredelevator = [self imageWithImage:[UIImage imageNamed:@"elevatorinactive.png"] scaledToSize:CGSizeMake(20, 20)];
    bgreenelevator = [self imageWithImage:[UIImage imageNamed:@"elevatoractive.png"] scaledToSize:CGSizeMake(20, 20)];
    
    redelevator = [self imageWithImage:[UIImage imageNamed:@"elevatorinactive.png"] scaledToSize:CGSizeMake(10, 10)]; // Ich dachte, wenn ich die Bilder einmal so speichere kann ich sie effizienter aufrufen....
    greenelevator = [self imageWithImage:[UIImage imageNamed:@"elevatoractive.png"] scaledToSize:CGSizeMake(10, 10)]; // same
    
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
    interface.mapviewadam = (id)self; // Ich bin dein daddy
    
    // Location Manager! Warum initaliziere ich den eigentlich zwei mal?!
    
    
    if (userl)
    {
    _map.showsUserLocation = YES;
    }
    
    // Hier kommt das Ding was so viel Speicher zieht
    _map = [[JFMapView alloc]initWithFrame:self.frame]; // DIE MAP!
    [_map setMapType:MKMapTypeStandard];
    
    [_map setZoomEnabled:YES];
    [_map setScrollEnabled:YES];
    [_map setPitchEnabled:YES];
    [_map setShowsCompass:NO];
    [_map setShowsTraffic:YES];
    [_map setShowsBuildings:YES];
    
    
    [_map setTintColor:[UIColor blackColor]];
    
    _map.delegate = (id)self;
    if (userl)
    {
    _map.showsUserLocation = YES; // Jaja, du bist echt toll
    }
    
    
    [self addSubview:_map];
    
    
    
    
    // MAP TILE
    
    self.rotCamera = [[FSRotatingCamera alloc] initWithMapView:self.map];
    
    if ([USE_TILE isEqualToString:(@"YES")])
    {
    self.gridOverlay = [[GridTileOverlay alloc] init];
    self.gridOverlay.canReplaceMapContent=YES;
    [self.mapView addOverlay:self.gridOverlay level:MKOverlayLevelAboveRoads];
    // Do any additional setup after loading the view from its nib.
    self.overlaySelector.selectedSegmentIndex = CustomMapTileOverlayTypeOffline;

    [self reloadTileOverlay];
    }
    
    NSMutableArray *geos = [_fromage coords]; // Jetzt die Koordinatenaufbereitung vorbereiten
    
    __block int drei;
    drei = 0; // Übrigens, die counter heißen bei mir fast immer irgendwas mit drei ^^
    
    points = [[NSMutableArray alloc]init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
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
            
            if ([ident isEqualToString:(@"SHOWERROR")])
            {
                [self showerroralert];
            }
            //        NSLog(@"LONG %@",ident);
            if (![ident isEqualToString:(@"SHOWERROR")])
            {
                point.subtitle = ident; // Das ist echt viel wichtiger als es aussieht! Über diesen SUbtitle erkenne ich nämlich was ich dem Punkt zuweisen muss - von Bildern bis zu Beschreibungen und Koordinaten
                
                
                //        NSLog(@"%@",dictico.description);
                
                
                
                point.title = [_fromage.type objectAtIndex:drei]; // Titel setzen
                
                
                // Jaaa, das nennt man Speicherverwaltung!!
                
                [dictico removeAllObjects];
                dictico = nil;
                ident = nil;
                // Übersetzen
                if (!drei)
                {
                    printf("\n Es liegt ein Fehler vor!");
                    point.subtitle = (@"10009296");
                }
                if ([point.title isEqualToString:(@"ELEVATOR")])
                {
                    NSString *creator;
                    creator = [NSString stringWithFormat:@"%d",drei];
                    
                    point.title = (@"Aufzug bei Station: ");
                    if (creator)
                    {
                        point.title = [point.title stringByAppendingString:creator];
                    }
                    
                    creator = nil;
                }
                if ([point.title isEqualToString:(@"ESCALATOR")])
                {
                    NSString *creator;
                    creator = [NSString stringWithFormat:@"%d",drei];
                    point.title = (@"Rolltreppe bei Station: ");
                    point.title = [point.title stringByAppendingString:creator];
                    creator = nil;
                }
                
                [points addObject:point];
                drei++;
                
            }
            
        }
//        dispatch_async(dispatch_get_main_queue(), ^(void) {
//            for (MKPointAnnotation *point in points)
//            {
//                [self.map addAnnotation:point];
//            }
//        });
        self.clusteringManager = [[FBClusteringManager alloc] initWithAnnotations:points];
        
        
    });
    
//    for (NSObject *coordinate2 in geos) // eine for schleife um die latitude und die longitude in ein
//    {
//        NSMutableDictionary *dictico;
//        dictico = [_fromage dicforindex:drei];
//        
//        CLLocationCoordinate2D coordinate = [[geos objectAtIndex:drei] MKCoordinateValue];
//        //        NSLog(@"%f",coordinate.latitude);
//        //        NSLog(@"%f",coordinate.longitude);
//        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//        point.coordinate = coordinate;
//        NSString *ident;
//        //        ident = [dictico objectForKey:(@"equipmentnumber")]; // Hat nicht funktioniert, weißte
//        ident = [NSString stringWithFormat:@"%@",[dictico objectForKey:(@"equipmentnumber")]];
//        
//        if ([ident isEqualToString:(@"SHOWERROR")])
//        {
//            [self showerroralert];
//        }
//        //        NSLog(@"LONG %@",ident);
//        if (![ident isEqualToString:(@"SHOWERROR")])
//        {
//            point.subtitle = ident; // Das ist echt viel wichtiger als es aussieht! Über diesen SUbtitle erkenne ich nämlich was ich dem Punkt zuweisen muss - von Bildern bis zu Beschreibungen und Koordinaten
//            
//            
//            //        NSLog(@"%@",dictico.description);
//            
//            
//            
//            point.title = [_fromage.type objectAtIndex:drei]; // Titel setzen
//            
//            
//            // Jaaa, das nennt man Speicherverwaltung!!
//            
//            [dictico removeAllObjects];
//            dictico = nil;
//            ident = nil;
//            // Übersetzen
//            if (!drei)
//            {
//                printf("\n Es liegt ein Fehler vor!");
//                point.subtitle = (@"10009296");
//            }
//            if ([point.title isEqualToString:(@"ELEVATOR")])
//            {
//                NSString *creator;
//                creator = [NSString stringWithFormat:@"%d",drei];
//                
//                point.title = (@"Aufzug bei Station: ");
//                if (creator)
//                {
//                    point.title = [point.title stringByAppendingString:creator];
//                }
//                
//                creator = nil;
//            }
//            if ([point.title isEqualToString:(@"ESCALATOR")])
//            {
//                NSString *creator;
//                creator = [NSString stringWithFormat:@"%d",drei];
//                point.title = (@"Rolltreppe bei Station: ");
//                point.title = [point.title stringByAppendingString:creator];
//                creator = nil;
//            }
//            //        NSLog(@"%@",point.subtitle);
//            
//            // Und den ganzen Spaß hinzufügen!
//            [self.map addAnnotation:point];
//            drei++;
//            
//        }
//        
//    }
    
    
    // Stuttgart "Modus" ( Falls die Ortungsdienste deaktiviert sind )
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse && [CLLocationManager locationServicesEnabled])
    {
//        [self.viewc ortme];
    }
    else
    {
        printf("\n STUTTGART ");
        
    }
    
    
    self.map.alpha = 0.0; // Wegen Animation die gleich kommt...
    [self addSubview:interface]; // Das Interface hinzufügen
    interface.hidden = YES;
    self.map.showsBuildings = YES;
    
    
//    NSLog(@"%@",_map.overlays.description);
    
    if ([_fromage.description_ count]==0)
    {
        
        [self.viewc presentMessagewithexit:(@"Es ist ein Fehler aufgetreten. Bitte die App schließen")]; //# TODO
    }
    NSLog(@"%lu Objekte geladen.",(unsigned long)[_fromage.description_ count]); // Kleiner Log
//    AIzaSyAfN0znfkVve3HM5itywturlxOpF2Rl9FA // Das hier einfach ignorieren ^^
    
//    [self drawRoute:geos];
    
    
//    [geos removeAllObjects];
    geos = nil;
//    WildcardGestureRecognizer * tapInterceptor = [[WildcardGestureRecognizer alloc] init];
//    tapInterceptor.touchesBeganCallback = ^(NSSet * touches, UIEvent * event) {
//        if (_map.camera.altitude > 120000.00 && !_modifyingMap) {
//            _modifyingMap = YES; // prevents strange infinite loop case
//            printf("\n STOP ZOOM");
//            
//            [UIView beginAnimations:nil context:nil];
//            [_map.camera setAltitude:120000.00];
//            [UIView commitAnimations];
//            
//            
//            _modifyingMap = NO;
//            
//        }
//        
//    };
//    [_map addGestureRecognizer:tapInterceptor];
    
//    [self.viewc ortme];
    
    
    // ADD BACK BUTTON
    
    back_camera = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.viewc.view.frame.size.width, self.viewc.view.frame.size.height/30)];
    [back_camera setTitle:(@"Auswahl verlassen") forState:UIControlStateNormal];
    [back_camera setBackgroundColor:[UIColor blackColor]];
    [back_camera setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back_camera setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [back_camera addTarget:self action:@selector(unselectannot) forControlEvents:UIControlEventPrimaryActionTriggered];
    [self.viewc.view addSubview:back_camera];
    back_camera.hidden = YES;
}

//DESELEKTIEREN
-(void)unselectannot
{
    [self.map deselectAnnotation:[self.map selectedAnnotations].firstObject animated:YES];
}
///Das ist die Startposition
-(void)setgermany
{
    [self.map setRegion:startregion animated:YES];
    
}
- (double)getZoomLevel
{
    CLLocationDegrees longitudeDelta = _map.region.span.longitudeDelta;
    CGFloat mapWidthInPixels = self.bounds.size.width;
    double zoomScale = longitudeDelta * MERCATOR_RADIUS * M_PI / (180.0 * mapWidthInPixels);
    double zoomer = MAX_GOOGLE_LEVELS - log2( zoomScale );
    if ( zoomer < 0 ) zoomer = 0;
    //  zoomer = round(zoomer);
    return zoomer;
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
//                         MBProgressHUD * hud =  [MBProgressHUD showHUDAddedTo:self.viewc.view animated:YES];
//                         hud.detailsLabel.text = (@"Region: Stuttgart");
                         
                         [MKMapView animateWithDuration:0.5 animations:^{
                             [self.map setRegion:region animated:YES];
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:1.0 animations:^{
//                                 [MBProgressHUD HUDForView:self.viewc.view];
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
        printf("\n FAILING ");
        
    [_map setRegion:[_map regionThatFits:region] animated:YES];
    updated = YES;
    }
    
}

- (void) drawRoute:(NSArray *) path
{
    NSInteger numberOfSteps = 5;
    
    CLLocationCoordinate2D coordinates[numberOfSteps];
    for (NSInteger index = 0; index < numberOfSteps; index++) {
        CLLocation *location = [path objectAtIndex:index];
        CLLocationCoordinate2D coordinate = location.coordinate;
        coordinates[index] = coordinate;
        printf("\n Worked");
        
    }
    
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
    [self.map addOverlay:polyLine];
    
}

///Spaß mit Annotationen
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[FBAnnotationCluster class]]) {
        
        FBAnnotationCluster *cluster = (FBAnnotationCluster *)annotation;
        int annotcount;
        annotcount = (int)cluster.annotations.count;
        cluster.title = [NSString stringWithFormat:@"%d",annotcount];
        
        NSString *identifier = [NSString stringWithFormat:@"CL%d",(int)[annotation subtitle]];
        //        NSLog(@"%@",identifier);
        
        MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:identifier];
        annotationView.image = [UIImage imageNamed:@"adam_group.png"];
        UILabel *sizeofcluster;
        sizeofcluster = [[UILabel alloc]initWithFrame:CGRectMake((annotationView.frame.size.width/2)-annotationView.frame.size.height/3, 0, (annotationView.frame.size.height/3)*2, annotationView.frame.size.height)];
        sizeofcluster.text = cluster.title;
        sizeofcluster.font = [UIFont boldSystemFontOfSize:annotationView.frame.size.height/3];
        sizeofcluster.textAlignment = NSTextAlignmentCenter;
        
        [annotationView addSubview:sizeofcluster];
        
        annotationView.canShowCallout = NO;
        return annotationView;
        
    } else {
        //Erstmal schauen ob das der Userstandort ist
        if ([annotation isKindOfClass:[MKUserLocation class]])
        {
            ((MKUserLocation *)annotation).title = @"Hier bist du";
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
            annotationView.detailCalloutAccessoryView = [self detailViewForAnnotation:annotationView];
            
            // Und das ganze schön langsam einblenden, dann fällt es nicht auf wie kacke das eigentlich reinploppt //Das klappt nicht mehr so gut, seit ich reuse-teile verwende. Deshalb ist das jetzt auch am anfang :D
            
            status = nil;
            typee = nil;
            return annotationView; // Dann nur noch zurückgeben!
        }
    }

    return nil;
}
- (UIButton *)yesButton {
    UIImage *image = [UIImage imageNamed:(@"noscio100.png")];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height); // don't use auto layout
    [button setImage:image forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    return button;
}
- (UIView *)detailViewForAnnotation:(MKAnnotationView *)annotation {
    UIView *view = [[UIView alloc] init];
    
    view.translatesAutoresizingMaskIntoConstraints = false;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = [annotation.annotation subtitle];
    
    label.font = [UIFont systemFontOfSize:20];
    label.translatesAutoresizingMaskIntoConstraints = false;
    label.numberOfLines = 1;
    
    
    NSString *identi;
    identi = [annotation.annotation subtitle];
    
    NSString *descrip;
    MarqueeLabel *extratext = [[MarqueeLabel alloc]initWithFrame:CGRectMake(0, 0, 120, 20)];
    descrip = [self.fromage desforquipmentnumber:identi];
    
    
    if (descrip)
    {
    if ([descrip isEqualToString:(@"")])
    {
        [view addSubview:extratext];
        extratext.text = (@"Keine Beschreibung");
        extratext.font = [UIFont systemFontOfSize:self.frame.size.height/50];
    }
    if (descrip)
    {
        [view addSubview:extratext];
        extratext.text = descrip;
        extratext.animationDelay = .2;
        extratext.scrollDuration = 1.0;
        extratext.font = [UIFont boldSystemFontOfSize:self.frame.size.height/60];
    }
    }
    if (!descrip)
    {
        [view addSubview:extratext];
        extratext.text = (@"Keine Beschreibung");
        extratext.font = [UIFont systemFontOfSize:self.frame.size.height/50];
    }
    NSDictionary *views = NSDictionaryOfVariableBindings(extratext);
    
//    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|" options:0 metrics:nil views:views]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:extratext attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[extratext]|" options:0 metrics:nil views:views]];
    
    return view;
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
        // Die Animation wird nach dem Rendern der Map ausgeführt, eigentlich ganz cool
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         [self setstuttgart];
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
         startregion = self.map.region;
         [MBProgressHUD hideHUDForView:_viewc.view animated:YES]; // Und natürlich das HUD verstecken, sind ja mit dem Groben fertig
     }];
    }
    
}
///Error anzeigen!
-(void)showerror
{
    UIAlertController *control;
    control = [UIAlertController alertControllerWithTitle:(@"Aktion abgebrochen.") message:(@"Der Crash der App wurde verhindert. Offenbar fehlen in der ADAM-API Daten, welche für das Ausführen der gewünschten Aktion erforderlich sind. Beim Klicken auf \"In Ordnung\" werden sie wieder auf die Startposition gesetzt.") preferredStyle:UIAlertControllerStyleAlert]; // Erstellen
    
    UIAlertAction* inordnung = [UIAlertAction actionWithTitle:(@"In Ordnung") style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self setgermany]; // Das ist der Handler
                                                          }];
    
    [control addAction:inordnung];
    [self.viewc presentViewController:control animated:YES completion:nil]; // und anzeigen
    
    
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view // Das wird aufgerufen wenn man auf eine Annotation klickst
{
    if ([view.annotation isKindOfClass:[FBAnnotationCluster class]])
    {
        clusterZoom = YES;
        FBAnnotationCluster *cluser;
        cluser = (FBAnnotationCluster*)view.annotation;
        [_map showAnnotations:cluser.annotations animated:YES];
    }
    if (![view.annotation isKindOfClass:[FBAnnotationCluster class]])
    {
    int validone;
    validone = 1;
    if ([view.annotation isKindOfClass:[MKUserLocation class]])
    {
        validone = 2;
    }
    
    
    if ([[[view annotation] subtitle] isEqualToString:(@"10009296")])
    {
        validone = 0;
    }
    if ([[[view annotation] subtitle] isEqualToString:(@"10440292")])
    {
        validone = 0;
    }
    if ([[[view annotation] subtitle] isEqualToString:(@"10272242")])
    {
        validone = 0;
    }
    if (validone == 0)
    {
        [self.map deselectAnnotation:view.annotation animated:YES];
        [self showerror];
    }
    
    if (validone == 1)
    {
        
        _map.userInteractionEnabled = NO;
//        selected_point = YES;
//        [self.map setShowsPointsOfInterest:NO];
        back_camera.alpha = 0.0;
        back_camera.hidden = NO;
    // Dann blende ich erstmal die Credits aus
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         self.viewc.ortung.alpha = 1.0;
         self.viewc.ortung.alpha = 0.0;
         self.viewc.credits.alpha = 1.0;
         self.viewc.credits.alpha = 0.0;
         back_camera.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
         
     }];
    self.viewc.datenschutz.hidden = YES;
    [interface loadforID:[[view annotation] subtitle]]; // Und lade das mit dem Subtitle ( von dem wird man noch öfter hören )
    
    oldregion = mapView.region; // ich merke mir die Region, dass ich wieder an die Stelle springen kann wo der Nutzer vor dem Klick war
    
//    MKMapCamera *newCamera=[[MKMapCamera alloc] init]; // Neue Camera für Animation mit Pitch
//        
//    //set a new camera angle
//    [newCamera setCenterCoordinate:CLLocationCoordinate2DMake([[view annotation]coordinate].latitude,[[view annotation]coordinate].longitude)];
//        
//    [newCamera setPitch:60.0];
//    [newCamera setAltitude:100.0];
//    [mapView setCamera:newCamera animated:YES]; // Mal hinfliegen
        
    [self.rotCamera startRotatingWithCoordinate:CLLocationCoordinate2DMake([[view annotation]coordinate].latitude,[[view annotation]coordinate].longitude)heading:-1 pitch:60.0 altitude:100.0 headingStep:5];
        
    // Hier wird das Bild von Google Streetview zu dem Ortsnamen geladen. Werde ich nicht erklären, ist selbsterklärend
        
    NSString *longi;
    NSString *lati;
    
    
    CLLocationCoordinate2D point;
    point = [[view annotation] coordinate];
    
    longi = [[NSNumber numberWithDouble:point.longitude] stringValue];
    lati = [[NSNumber numberWithDouble:point.latitude] stringValue];
    
    
    //    7.590019933
    //    50.358767133
    
    //    https://maps.googleapis.com/maps/api/streetview?size=600x300&location=46.414382,10.013988&heading=151.78&pitch=-0.76&key=
    NSString *urlmaker;
        
    urlmaker = (@"https://maps.googleapis.com/maps/api/streetview?size=500x200&location=");
    
//    urlmaker = [urlmaker stringByAppendingString:lati];
//    urlmaker = [urlmaker stringByAppendingString:(@",")];
//    urlmaker = [urlmaker stringByAppendingString:longi];
    NSString *locii;
    locii = [nummerbahnnow valueForKey:[[view annotation] subtitle]];
    locii = [locii stringByReplacingOccurrencesOfString:(@" Hbf") withString:(@"")];
    if (locii)
    {
        if ([locii isEqualToString:(@"")])
        {
    locii = (@"Irsadas");
    urlmaker = [urlmaker stringByAppendingString:locii];
        }
    }
        
    urlmaker = [urlmaker stringByAppendingString:(@"&key=")];
    urlmaker = [urlmaker stringByAppendingString:(@"AIzaSyAfN0znfkVve3HM5itywturlxOpF2Rl9FA")];
    NSString *urlmaked = [urlmaker stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    [interface setimageurl:urlmaked]; // Hier werden die Bilder gesetzt.
        
    //Fertig!
      
        
        NSString *identi;
        identi = [[view annotation] subtitle]; // Jetzt seht ihr gleich warum das so wichtig ist
        NSString *status;
        NSString *typee;
        typee = [self.fromage typeforquipmentnumber:identi]; // Unfassbar umständlich, ich weiß. Aber es klappt!!
        status = [self.fromage statusforquipmentnumber:identi]; // Hier gehts auch noch
        if ([typee isEqualToString:(@"ESCALATOR")]) //Rolltreppe
        {
            view.image = [UIImage imageNamed:@"costumann.png"];
            
            if ([status isEqualToString:(@"ACTIVE")])
            {
                
                view.image = [UIImage imageNamed:@"greenann.png"];
            }
            
        }
        if ([typee isEqualToString:(@"ELEVATOR")]) // und Aufzug
        {
            view.image = bredelevator;
            if ([status isEqualToString:(@"ACTIVE")])
            {
                view.image = bgreenelevator;
            }
        }

        
    }
    }
    
    
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(nonnull MKAnnotationView *)view // Wird beim deselecten der Annotation aufgerufen
{
    selected_point = NO;
    
    if (![view.annotation isKindOfClass:[FBAnnotationCluster class]])
    {
    int validone;
    validone = 1;
    if ([view.annotation isKindOfClass:[MKUserLocation class]])
    {
        validone = 2;
    }
    
    if ([[[view annotation] subtitle] isEqualToString:(@"10009296")]) // Das ist nur #pragma tisch. :D Das könnte man durchaus schlauer lösen
    {
        validone = 0;
    }
    if ([[[view annotation] subtitle] isEqualToString:(@"10440292")])
    {
        validone = 0;
    }
    if ([[[view annotation] subtitle] isEqualToString:(@"10272242")])
    {
        validone = 0;
    }
    if (validone == 1)
    {
        // Und wieder auf die alte Position!
        [self.rotCamera stopRotating];
    self.viewc.datenschutz.hidden = NO; // Datenschutz unhidden
    [UIView animateWithDuration:1.4
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         _map.userInteractionEnabled = YES;
         back_camera.alpha = 0.0;
         NSString *identi;
         identi = [[view annotation] subtitle]; // Jetzt seht ihr gleich warum das so wichtig ist
         NSString *status;
         NSString *typee;
         typee = [self.fromage typeforquipmentnumber:identi]; // Unfassbar umständlich, ich weiß. Aber es klappt!!
         status = [self.fromage statusforquipmentnumber:identi]; // Hier gehts auch noch
         if ([typee isEqualToString:(@"ESCALATOR")]) //Rolltreppe
         {
             view.image = [UIImage imageNamed:@"costumann.png"];
             
             if ([status isEqualToString:(@"ACTIVE")])
             {
                 
                 view.image = [UIImage imageNamed:@"greenann.png"];
             }
             
         }
         if ([typee isEqualToString:(@"ELEVATOR")]) // und Aufzug
         {
             view.image = redelevator;
             if ([status isEqualToString:(@"ACTIVE")])
             {
                 view.image = greenelevator;
             }
         }
         self.mapView.alpha = 1.0;
         self.viewc.credits.alpha = 0.0;
         self.viewc.credits.alpha = 1.0;
         self.viewc.ortung.alpha = 0.0;
         self.viewc.ortung.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
         
     }];
//    [self.map setShowsPointsOfInterest:YES];
        back_camera.hidden = YES;
    [mapView setRegion:oldregion animated:YES];
    [interface sethiddennow]; // Sagt dem Interface dass es verschwinden kann
        
    }
    }
    
}
/// Das musste ich vorerst weglassen - Gab ein paar Fehler!
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
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    if (![self.rotCamera isStopped] == NO)
    {
    [[NSOperationQueue new] addOperationWithBlock:^{
        double scale = _map.bounds.size.width / _map.visibleMapRect.size.width;
        NSLog(@"%f",scale);
        
        NSArray *annotations = nil;
        if (scale < 0.346771) {
            annotations = [self.clusteringManager clusteredAnnotationsWithinMapRect:mapView.visibleMapRect withZoomScale:scale];
        } else {
            annotations = points;
        }
        [self.clusteringManager displayAnnotations:annotations onMapView:mapView];
    }];
    }
    
    if ([self.rotCamera isStopped] == NO) {
        [self.rotCamera continueRotating];
    }
    
    
}

-(void)showerroralert
{
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    
    [alert showError:@"Oje..." subTitle:@"Aus einem unbekannten Grund kann die App einfach keine Verbindung zu den Bahnservern herstellen. Möglicherweise sind die offline. Versuche es später erneut. Schließe die App jetzt." closeButtonTitle:nil duration:0.0f];
    
    
    [alert addTimerToButtonIndex:0 reverse:NO];
    [alert alertIsDismissed:^{
        exit(0);
        
    }];
}
// TILE

- (IBAction)overlaySelectorChanged:(id)sender {
    self.overlayType=CustomMapTileOverlayTypeOffline;
    [self reloadTileOverlay];
}
-(void)reloadTileOverlay {
    
    printf("\n ASDSA D");
    
    // remove existing map tile overlay
    if(self.tileOverlay) {
        [self.mapView removeOverlay:self.tileOverlay];
    }
    
    // define overlay
    if(self.overlayType==CustomMapTileOverlayTypeApple) {
        // do nothing
        self.tileOverlay = nil;
        
    } else if(self.overlayType==CustomMapTileOverlayTypeOpenStreet || self.overlayType==CustomMapTileOverlayTypeGoogle) {
        // use online overlay
        NSString *urlTemplate = nil;
        if(self.overlayType==CustomMapTileOverlayTypeOpenStreet) {
            urlTemplate = @"http://c.tile.openstreetmap.org/{z}/{x}/{y}.png";
        } else {
//            urlTemplate = @"http://mt0.google.com/vt/x={x}&y={y}&z={z}";
            urlTemplate = @"http://tile.stamen.com/watercolor/{z}/{x}/{y}.jpg";
        }
        self.tileOverlay = [[MKTileOverlay alloc] initWithURLTemplate:urlTemplate];
        self.tileOverlay.canReplaceMapContent=YES;
        [self.mapView insertOverlay:self.tileOverlay belowOverlay:self.gridOverlay];
    }
    else if(self.overlayType==CustomMapTileOverlayTypeOffline) {
        NSString *baseURL = [[[NSBundle mainBundle] bundleURL] absoluteString];
        NSString *urlTemplate = [baseURL stringByAppendingString:@"/tiles/{z}/{x}/{y}.png"];
        self.tileOverlay = [[MKTileOverlay alloc] initWithURLTemplate:urlTemplate];
        self.tileOverlay.canReplaceMapContent=YES;
        [self.mapView insertOverlay:self.tileOverlay belowOverlay:self.gridOverlay];
    }
    
    
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    
    if([overlay isKindOfClass:[MKTileOverlay class]]) {
        MKTileOverlay *tileOverlay = (MKTileOverlay *)overlay;
        MKTileOverlayRenderer *renderer = nil;
        if([tileOverlay isKindOfClass:[GridTileOverlay class]]) {
#if ( OFFLINE_USE_CUSTOM_OVERLAY_RENDERER == 1 )
            renderer = [[GridTileOverlayRenderer alloc] initWithTileOverlay:tileOverlay];
#else
            renderer = [[MKTileOverlayRenderer alloc] initWithTileOverlay:tileOverlay];
#endif
        } else {
            if(self.overlayType==CustomMapTileOverlayTypeGoogle) {
                renderer = [[WatermarkTileOverlayRenderer alloc] initWithTileOverlay:tileOverlay];
            } else {
                renderer = [[MKTileOverlayRenderer alloc] initWithTileOverlay:tileOverlay];
            }
        }
        
        return renderer;
    }
    
    return nil;
}



@end
