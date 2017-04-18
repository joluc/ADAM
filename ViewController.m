//
//  ViewController.m
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import "ViewController.h"
#import "ADAMCom.h"
#import "ADAMerci.h"
#import "ADAM_MapView.h"
#import "MBProgressHUD.h"
#import "CheckConnection.h"
#import "outrepasser.h"
#import <CoreData/CoreData.h>
#import <CWStatusBarNotification.h>
#import "SearchControllerViewController.h"
#import "Informationeninterface.h"
#import "InfoViewTable.h"
#import "UIColor+Hex.h"
#import "UIFont+MoreFont.h"
#import "SearchView.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import <AMPopTip.h>





@interface ViewController ()<CLLocationManagerDelegate>

@end
NSMutableDictionary *dictim;
NSMutableArray *nummerext;
NSMutableArray *stationlong;
NSMutableDictionary *nummerbahn;
ADAMerci *baguette;
MBProgressHUD *hud;
SearchControllerViewController *viewControllersearch;
Informationeninterface *infoface;
InfoViewTable *infoviewtable;
SearchView *searchview;




BOOL useOld;



@implementation ViewController
@synthesize datenschutz;
@synthesize credits;
@synthesize ortung;
@synthesize com;
@synthesize navbar;
@synthesize mapView;





- (void)viewDidLoad {
    
    
<<<<<<< Updated upstream
    
    
=======
>>>>>>> Stashed changes
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(enterbackground)
                                                 name: UIApplicationDidEnterBackgroundNotification
                                               object: nil]; // Ruf mich an wenn du in den Background gehst, Süßer
    
<<<<<<< Updated upstream
    
=======
>>>>>>> Stashed changes
    [super viewDidLoad];
    [self startupcheck]; //Überprüfe die Verbindung
    
    
}
-(void)hidenavbar
{
    navbar.hidden = true;
}
-(void)shownavbar
{
    navbar.hidden = false;
}

///Verbindung überprüfen und dann starten oder Fehlermeldeung ausgeben
-(void)startupcheck
{
    CheckConnection *checker;
    checker = [[CheckConnection alloc]init];
    
    if ([checker checkfnc]) //Wenn eine Verbindung vorhanden ist
    {
        [self runner];
        
    }
    if (![checker checkfnc]) //Wenn keine Verbindung vorhanden ist
    {
        
        NSTimer *timernew; // Kurzes Delay, dass sich das UI updaten kann
        timernew = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(run_error) userInfo:nil repeats:NO];
    }
    
    checker = nil;
    
}
-(void)runner
{
    
    locationManager = [[CLLocationManager alloc] init]; // Mache dieses blöde Location Manager Zeugs
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [locationManager requestWhenInUseAuthorization];
    }
    if (![CLLocationManager locationServicesEnabled])
    {
    [locationManager startUpdatingLocation]; //Starte Location Updates
    }
    
    credits = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 10)]; // Credits Button erstellen
    [credits setBackgroundColor:[UIColor clearColor]];
    [credits.titleLabel setFont:[UIFont systemFontOfSize:self.view.frame.size.height/55]];
    [credits setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [credits setTitle:(@"Daten bereitgestellt von der Deutschen Bahn / ADAM\nFreepik | Creative Commons BY 3.0 | CC 3.0 BY") forState:UIControlStateNormal]; // Text für Credits setzen
    credits.titleLabel.numberOfLines = 2; // Das Ding hat 2 Linien
    
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES]; //HUD aktivieren und Objekt abgreifen für Modifikationen
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.text = (@"Lade Daten vom Server..."); //Schönen Text beim HUD setzen
    hud.label.text = (@"Das kann ein Weilchen dauern.");
    
    
    NSTimer *timernew; // Kurzes Delay, dass sich das UI updaten kann
    timernew = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(run_debut) userInfo:nil repeats:NO];
    NSTimer *timernewnew; // Kurzes Delay, dass sich das UI updaten kann
    timernewnew = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(testanother) userInfo:nil repeats:NO];
    
    [credits addTarget:self action:@selector(showcreditalert) forControlEvents:UIControlEventPrimaryActionTriggered]; // Die Action für den Credits Button setzen
    
    credits.titleLabel.textAlignment = NSTextAlignmentCenter; //Text Aligment setzen
    
<<<<<<< Updated upstream
=======
    
    
    
>>>>>>> Stashed changes
    
}
///Die Methode hat nen blöden Namen weil ich was testen wollte, hab aber keine Lust das zu ändern - funktioniert jetzt ja
-(void)testanother
{
    
    NSURL *imgPath = [[NSBundle mainBundle] URLForResource:@"stationsdaten" withExtension:@"json"];
    NSString*stringPath = [imgPath absoluteString]; //this is correct
    
    //you can again use it in NSURL eg if you have async loading images and your mechanism
    //uses only url like mine (but sometimes i need local files to load)
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringPath]];
    
    dictim = [self dicfromdata:data]; //Aufzugsdaten in Dictionary schieben
    fullele = [dictim mutableCopy];
    
    nummerext = [dictim valueForKeyPath:@"Equipment"]; //Alle Equip abgreifen
    stationlong = [dictim valueForKeyPath:@"Ort"]; // Alle Orte abgreifen
    
    nummerbahn = [NSMutableDictionary new];
    int dreii = 0;
    
    for (NSString *key in nummerext) {
        NSString *realkey;
        realkey = [NSString stringWithFormat:@"%lld", key.longLongValue];
        
        [nummerbahn setValue:[stationlong objectAtIndex:dreii] forKey:realkey]; // Jetzt ein Dictionary erstellen, wo ich anhand der Equipmentnummer den Ort rauskrieg
        dreii++;
    }
    
//    NSLog(@"%@", nummerbahn);
    
    nummerbahnnow = [nummerbahn mutableCopy]; // Und das ganze global schalten. Finito!
    
    // Und hier mal wieder Speicherverwaltung
    data = nil;
    stringPath = nil;
    imgPath = nil;
    
}
-(NSMutableDictionary*)dicfromdata:(NSData*)responseData
{
    
    NSError* error;
    NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
//    NSLog(@"%@",json.description);
    
    return json;
}
//MESSAGE TO USER
-(void)presentMessagewithexit:(NSString *)message
{
    UIAlertController *control;
    control = [UIAlertController alertControllerWithTitle:(@"Hinweis") message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"App schließen"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             NSData *data;
                             exit(0); // CRASH IT
                         }];
<<<<<<< Updated upstream
    [control addAction:ok];
    
    
=======
    UIAlertAction* old_api = [UIAlertAction
                         actionWithTitle:@"Zuletzt empfangenen Daten nutzen"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             useOld = true;
                         }];
    UIAlertAction* local_data = [UIAlertAction
                                 actionWithTitle:@"Lokale Daten nutzen"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [hud showAnimated:YES];
                                     hud.label.text = (@"Lade lokale Daten...");
                                     hud.detailsLabel.text = (@"Achtung, diese sind möglicherweise nicht aktuell.");
                                     [self run_debut_local];
                                 }];
    [control addAction:local_data];
    [control addAction:ok];
    
>>>>>>> Stashed changes
    [self presentViewController:control animated:YES completion:nil];
}

///Fehler wegen Internet anzeigen
-(void)run_error
{
    UIAlertController *control;
    control = [UIAlertController alertControllerWithTitle:(@"Keine Verbindung") message:(@"Die Daten können nicht abgerufen werden. Es besteht keine aktive Verbindung zum Internet") preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Erneut versuchen"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self startupcheck]; // Nochmal StartupCheck durchlaufen lassen
                         }];
    UIAlertAction* old_api = [UIAlertAction
                              actionWithTitle:@"Zuletzt empfangenen Daten nutzen"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  useOld = true;
                                  [self run_debut];
                                  
                              }];
    UIAlertAction* local_data = [UIAlertAction
                              actionWithTitle:@"Lokale Daten nutzen"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  
                                  [self run_debut_local];
                              }];
    [control addAction:local_data];
    [control addAction:ok];
    
    
    [self presentViewController:control animated:YES completion:nil];
}
-(void)run_debut_local
{
    _loadingindicator = [[UIActivityIndicatorView alloc]initWithFrame:self.view.frame]; //Ladeding initializieren
    [self activateloader]; //Das könnte eigentlich raus, aber vielleicht brauche ich es mal!
    
    
    com = [[ADAMCom alloc]init]; // ADAMCom vorbereiten
    com.loadLocal = true;
    baguette = [[ADAMerci alloc]init]; //Und das ADAMerci vorbereiten
    baguette = [com dictionary_fromADAM]; // Los!
    
    mapView = [[ADAM_MapView alloc]initWithFrame:self.view.frame]; // Jetzt kommt die ADAM_MapView!
    [self.view addSubview:mapView];
    
    mapView.viewc = (id)self;
    
    if (!useOld)
    {
        mapView.fromage = baguette; // Brot mit Käse
    }
    if (useOld)
    {
        mapView.fromage = [com loadLatest]; // Brot mit Käse
        
    }
    [self.view addSubview:mapView]; // Mal adden
    
    [mapView setup]; // aufsetzen
    //    [self.view addSubview:credits]; // Und adden ( deprecated )
    
    
    navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UINavigationItem *navItem;
    navItem = [[UINavigationItem alloc]initWithTitle:(@"ADAM")];
    navItem.titleView.tintColor = [UIColor colorWithCSS:@"#FE6500"];
    
    
    //    [credits addTarget:self action:@selector(showcreditalert) forControlEvents:UIControlEventPrimaryActionTriggered]; // Die Action für den Credits Button setzen
    UIBarButtonItem *about_button = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Über"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(showcreditalert)];
    about_button.tintColor = [UIColor colorWithCSS:@"#FE6500"];
    navItem.rightBarButtonItem = about_button;
    
    
    UIBarButtonItem *search_button = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(addSearchView)];
    search_button.tintColor = [UIColor colorWithCSS:@"#FE6500"];
    navItem.leftBarButtonItem = search_button;
    navItem.leftBarButtonItem.enabled = false;
    
    
    navbar.items = @[navItem];
    //do something like background color, title, etc you self
    [self.view addSubview:navbar];
    
    // Hier kommt jetzt erstmal UI Gedöns
    datenschutz = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-self.view.frame.size.width/5, self.view.frame.size.height-15,self.view.frame.size.width/5, 10)];
    
    
    datenschutz.titleLabel.textAlignment = NSTextAlignmentRight;
    [datenschutz setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [datenschutz addTarget:self action:@selector(showprivacy) forControlEvents:UIControlEventPrimaryActionTriggered];
    [datenschutz setTitle:(@"Datenschutz") forState:UIControlStateNormal];
    [datenschutz.titleLabel setFont:[UIFont systemFontOfSize:self.view.frame.size.height/56]];
    [datenschutz setBackgroundColor:[UIColor whiteColor]];
    
    //    [self.view addSubview:datenschutz];
    
    //Datenschutzvereinbarung anzeigen wenn noch nicht geschehen
    if (![[NSUserDefaults standardUserDefaults]boolForKey:(@"privacy2")])
    {
        [self showprivacy];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:(@"privacy2")];
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        //    ortung = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-self.view.frame.size.width/10, self.view.frame.size.height-(35+self.view.frame.size.width/15),self.view.frame.size.width/10, self.view.frame.size.width/10)];
        ortung = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, self.view.frame.size.height-50,50, 50)];
        
        [ortung setImage:[UIImage imageNamed:(@"smalladam.png")] forState:UIControlStateNormal];
        [self.view addSubview:ortung];
        ortung.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [ortung addTarget:self action:@selector(ortme) forControlEvents:UIControlEventPrimaryActionTriggered];
    }
    
    // Das wars!
    printf("\n UI Bereit");
    
    //Momentan braucht man den Datenschutz nicht noch extra anzeigen.
    datenschutz = nil;
    
    
    // ADAMCom auf ViewDownInterface konfigurieren
    
    
    //    com = nil;
    
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        if (![[NSUserDefaults standardUserDefaults]boolForKey:(@"ignore")])
        {
            //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            UIAlertController *controller;
            controller = [UIAlertController alertControllerWithTitle:(@"Hinweis") message:(@"Die Ortungsdienste wurden deaktiviert.") preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *action_change = [UIAlertAction actionWithTitle:(@"Zu den Einstellungen") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
            
            UIAlertAction *action_ignore = [UIAlertAction actionWithTitle:(@"Nicht mehr darauf hinweisen.") style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action ){
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:(@"ignore")];
            }];
            
            UIAlertAction *action_later = [UIAlertAction actionWithTitle:(@"Beim nächsten App-Start darauf hinweisen") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action ){
                
            }];
            
            [controller addAction:action_change];
            [controller addAction:action_ignore];
            [controller addAction:action_later];
            
            [self presentViewController:controller animated:YES completion:nil];
            
        }
        
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        //        [self ortme];
    }
    
    
    
    infoface = [[Informationeninterface alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-(mapView.frame.size.height/7+self.view.frame.size.height/4), self.view.frame.size.width, self.view.frame.size.height/4)];
    [self.view addSubview:infoface];
    infoface.hidden = true;
    
    //    infoface.frame = CGRectMake(0, self.view.frame.size.height-(mapView.frame.size.height/7+self.view.frame.size.height/4), self.view.frame.size.width, self.view.frame.size.height/4);
    
    //    infoface = [[Informationeninterface alloc]initWithFrame:self.view.frame];
    
    infoface.backgroundColor = [UIColor clearColor];
    
}

///Hier liegt das Herz der ganze Sache, wenn das nicht ausgeführt wird geht gar nichts
-(void)run_debut
{
    _loadingindicator = [[UIActivityIndicatorView alloc]initWithFrame:self.view.frame]; //Ladeding initializieren
    [self activateloader]; //Das könnte eigentlich raus, aber vielleicht brauche ich es mal!
<<<<<<< Updated upstream
=======
    
    
    com = [[ADAMCom alloc]init]; // ADAMCom vorbereiten
    
    baguette = [[ADAMerci alloc]init]; //Und das ADAMerci vorbereiten
    baguette = [com dictionary_fromADAM]; // Los!
    
    mapView = [[ADAM_MapView alloc]initWithFrame:self.view.frame]; // Jetzt kommt die ADAM_MapView!
    [self.view addSubview:mapView];
    
    mapView.viewc = (id)self;
    
    if (!useOld)
    {
        mapView.fromage = baguette; // Brot mit Käse
    }
    if (useOld)
    {
        mapView.fromage = [com loadLatest]; // Brot mit Käse
        
    }
    [self.view addSubview:mapView]; // Mal adden
    
    [mapView setup]; // aufsetzen
//    [self.view addSubview:credits]; // Und adden ( deprecated )
    
    
    navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UINavigationItem *navItem;
    navItem = [[UINavigationItem alloc]initWithTitle:(@"ADAM")];
    navItem.titleView.tintColor = [UIColor colorWithCSS:@"#FE6500"];
    
    
//    [credits addTarget:self action:@selector(showcreditalert) forControlEvents:UIControlEventPrimaryActionTriggered]; // Die Action für den Credits Button setzen
    UIBarButtonItem *about_button = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Über"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(showcreditalert)];
    about_button.tintColor = [UIColor colorWithCSS:@"#FE6500"]; 
    navItem.rightBarButtonItem = about_button;
    
    
    UIBarButtonItem *search_button = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(addSearchView)];
    search_button.tintColor = [UIColor colorWithCSS:@"#FE6500"];
    navItem.leftBarButtonItem = search_button;
    
    
    navbar.items = @[navItem];
    //do something like background color, title, etc you self
    [self.view addSubview:navbar];
    
    // Hier kommt jetzt erstmal UI Gedöns
    datenschutz = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-self.view.frame.size.width/5, self.view.frame.size.height-15,self.view.frame.size.width/5, 10)];
    
    
    datenschutz.titleLabel.textAlignment = NSTextAlignmentRight;
    [datenschutz setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [datenschutz addTarget:self action:@selector(showprivacy) forControlEvents:UIControlEventPrimaryActionTriggered];
    [datenschutz setTitle:(@"Datenschutz") forState:UIControlStateNormal];
    [datenschutz.titleLabel setFont:[UIFont systemFontOfSize:self.view.frame.size.height/56]];
    [datenschutz setBackgroundColor:[UIColor whiteColor]];
    
//    [self.view addSubview:datenschutz];
    
    //Datenschutzvereinbarung anzeigen wenn noch nicht geschehen
    if (![[NSUserDefaults standardUserDefaults]boolForKey:(@"privacy2")])
    {
        [self showprivacy];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:(@"privacy2")];
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        //    ortung = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-self.view.frame.size.width/10, self.view.frame.size.height-(35+self.view.frame.size.width/15),self.view.frame.size.width/10, self.view.frame.size.width/10)];
        ortung = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, self.view.frame.size.height-50,50, 50)];
        
        [ortung setImage:[UIImage imageNamed:(@"smalladam.png")] forState:UIControlStateNormal];
        [self.view addSubview:ortung];
        ortung.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [ortung addTarget:self action:@selector(ortme) forControlEvents:UIControlEventPrimaryActionTriggered];
    }
    
    // Das wars!
    printf("\n UI Bereit");
    
    //Momentan braucht man den Datenschutz nicht noch extra anzeigen.
    datenschutz = nil;
    
    
    // ADAMCom auf ViewDownInterface konfigurieren
    
    
//    com = nil;
    
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        if (![[NSUserDefaults standardUserDefaults]boolForKey:(@"ignore")])
        {
            //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            UIAlertController *controller;
            controller = [UIAlertController alertControllerWithTitle:(@"Hinweis") message:(@"Die Ortungsdienste wurden deaktiviert.") preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *action_change = [UIAlertAction actionWithTitle:(@"Zu den Einstellungen") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
            
            UIAlertAction *action_ignore = [UIAlertAction actionWithTitle:(@"Nicht mehr darauf hinweisen.") style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action ){
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:(@"ignore")];
            }];
            
            UIAlertAction *action_later = [UIAlertAction actionWithTitle:(@"Beim nächsten App-Start darauf hinweisen") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action ){
                
            }];
            
            [controller addAction:action_change];
            [controller addAction:action_ignore];
            [controller addAction:action_later];
            
            [self presentViewController:controller animated:YES completion:nil];
            
        }
        
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
//        [self ortme];
    }
    
    
    
    infoface = [[Informationeninterface alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-(mapView.frame.size.height/7+self.view.frame.size.height/4), self.view.frame.size.width, self.view.frame.size.height/4)];
    [self.view addSubview:infoface];
    infoface.hidden = true;
    
//    infoface.frame = CGRectMake(0, self.view.frame.size.height-(mapView.frame.size.height/7+self.view.frame.size.height/4), self.view.frame.size.width, self.view.frame.size.height/4);

//    infoface = [[Informationeninterface alloc]initWithFrame:self.view.frame];
    
    infoface.backgroundColor = [UIColor clearColor];
    

    
    NSLog(@"SHOW NEWS INFO");
    
    [self shownews];
}
-(void)run_debut_old_api
{
    _loadingindicator = [[UIActivityIndicatorView alloc]initWithFrame:self.view.frame]; //Ladeding initializieren
    [self activateloader]; //Das könnte eigentlich raus, aber vielleicht brauche ich es mal!
>>>>>>> Stashed changes
    
    ADAMCom *com;
    com = [[ADAMCom alloc]init]; // ADAMCom vorbereiten
    com.old_api = false;
    
    
    baguette = [[ADAMerci alloc]init]; //Und das ADAMerci vorbereiten
    baguette = [com dictionary_fromADAM]; // Los!
    
    
    mapView = [[ADAM_MapView alloc]initWithFrame:self.view.frame]; // Jetzt kommt die ADAM_MapView!
    [self.view addSubview:mapView];
    mapView.viewc = (id)self;
    mapView.fromage = baguette; // Brot mit Käse
    
    [self.view addSubview:mapView]; // Mal adden
    
    [mapView setup]; // aufsetzen
    [self.view addSubview:credits]; // Und adden
    
    // Hier kommt jetzt erstmal UI Gedöns
    datenschutz = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-self.view.frame.size.width/5, self.view.frame.size.height-15,self.view.frame.size.width/5, 10)];
    
    
    datenschutz.titleLabel.textAlignment = NSTextAlignmentRight;
    [datenschutz setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [datenschutz addTarget:self action:@selector(showprivacy) forControlEvents:UIControlEventPrimaryActionTriggered];
    [datenschutz setTitle:(@"Datenschutz") forState:UIControlStateNormal];
    [datenschutz.titleLabel setFont:[UIFont systemFontOfSize:self.view.frame.size.height/56]];
    [datenschutz setBackgroundColor:[UIColor whiteColor]];
    
    //    [self.view addSubview:datenschutz];
    
    //Datenschutzvereinbarung anzeigen wenn noch nicht geschehen
    if (![[NSUserDefaults standardUserDefaults]boolForKey:(@"privacy2")])
    {
        [self showprivacy];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:(@"privacy2")];
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        //    ortung = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-self.view.frame.size.width/10, self.view.frame.size.height-(35+self.view.frame.size.width/15),self.view.frame.size.width/10, self.view.frame.size.width/10)];
        ortung = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, self.view.frame.size.height-50,50, 50)];
        
        [ortung setImage:[UIImage imageNamed:(@"smalladam.png")] forState:UIControlStateNormal];
        [self.view addSubview:ortung];
        ortung.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [ortung addTarget:self action:@selector(ortme) forControlEvents:UIControlEventPrimaryActionTriggered];
    }
    
    // Das wars!
    printf("\n UI Bereit");
    
    //Momentan braucht man den Datenschutz nicht noch extra anzeigen.
    datenschutz = nil;
<<<<<<< Updated upstream
//    com = nil;
=======
    [com setup];
    
>>>>>>> Stashed changes
    
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        if (![[NSUserDefaults standardUserDefaults]boolForKey:(@"ignore")])
        {
            //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            UIAlertController *controller;
            controller = [UIAlertController alertControllerWithTitle:(@"Hinweis") message:(@"Die Ortungsdienste wurden deaktiviert.") preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *action_change = [UIAlertAction actionWithTitle:(@"Zu den Einstellungen") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
            
            UIAlertAction *action_ignore = [UIAlertAction actionWithTitle:(@"Nicht mehr darauf hinweisen.") style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action ){
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:(@"ignore")];
            }];
            
            UIAlertAction *action_later = [UIAlertAction actionWithTitle:(@"Beim nächsten App-Start darauf hinweisen") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action ){
                
            }];
            
            [controller addAction:action_change];
            [controller addAction:action_ignore];
            [controller addAction:action_later];
            
            [self presentViewController:controller animated:YES completion:nil];
            
        }
        
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
<<<<<<< Updated upstream
//        [self ortme];
=======
        //        [self ortme];
>>>>>>> Stashed changes
    }
    
    
}

///Creditauswahl
-(void)showcreditalert
{
    UIAlertController *controller;
    controller = [UIAlertController alertControllerWithTitle:(@"Credits") message:(@"Danke an alle.") preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* db = [UIAlertAction actionWithTitle:(@"Deutsche Bahn (DB)") style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   [[UIApplication sharedApplication]openURL:[NSURL URLWithString:(@"http://data.deutschebahn.com")]];
                                               }];
    UIAlertAction* freep = [UIAlertAction actionWithTitle:(@"Freepik | Flaticon") style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * action) {
                                                      [[UIApplication sharedApplication]openURL:[NSURL URLWithString:(@"http://www.freepik.com")]];
                                                  }];
    UIAlertAction* noscio = [UIAlertAction actionWithTitle:(@"Entwickelt von Jonathan Fritz") style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [[UIApplication sharedApplication]openURL:[NSURL URLWithString:(@"https://noscio.eu")]];
                                                   }];
    UIAlertAction* close = [UIAlertAction actionWithTitle:(@"Schließen") style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                   }];
    
    [controller addAction:db];
    [controller addAction:freep];
    [controller addAction:noscio];
    [controller addAction:close];
    
    [self presentViewController:controller animated:YES completion:nil];
}
///Userlocation zentrieren
-(void)ortme
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    CLLocationCoordinate2D location;
    location.latitude = mapView.map.userLocation.coordinate.latitude;
    location.longitude = mapView.map.userLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [mapView.map setRegion:region animated:YES];
    
}
///Datenschutzcontroller anzeigen
-(void)showprivacy
{
    UIAlertController *priv;
    priv = [UIAlertController alertControllerWithTitle:(@"Datenschutz") message:(@"Deine Privatsphäre ist uns sehr wichtig. Deshalb stellt die App zu keinem Zeitpunkt eine Verbindung mit den Servern von Noscio her. Die Deutsche Bahn erhält möglicherweise bei dem Abrufen der Daten von ADAM Informationen darüber, welches Gerät du verwendest und wann du auf ADAM zugreifst. Dein Standort wird aber nicht übermittelt. Mit der Nutzung der App erklärst du dich mit diesen Bedingungen einverstanden.") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okay;
    okay = [UIAlertAction actionWithTitle:(@"In Ordnung") style:UIAlertActionStyleDefault handler:nil];
    [priv addAction:okay];
    [self presentViewController:priv animated:YES completion:nil];
    
}
///Das muss man unbedingt ausschalten, das sieht sonst so unfassbar scheiße aus
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

// 2 unnütze Methoden
-(void)activateloader
{
    
}
-(void)deactivateloader
{
    printf("\n Done ");
}

-(void)enterbackground
{
    printf("\n Uiii");
    // Alternativ könnte man hier ein paar Dinge tun!

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    printf("\n Memory Warning erhalten. Dein Gerät ist scheiße"); //Nutzer beleidigen weil ich nicht effizient (genug) programmiert habe
    
}
-(void)showsearchcontroller
{
    
}

-(void)displayingInformationInterface:(NSMutableDictionary*)dicinfo
{
    
    
    // INFORMATIONSTABLEVIEW
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        
        printf("\n SET ");
        NSLog(@"Description of Dictionary: %@",dicinfo.description);
        if (!dicinfo)
        {
            printf("\n Displaying NOTIFICATION");
            
            CWStatusBarNotification *notification = [CWStatusBarNotification new];
            notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
            notification.multiline = true;
            [notification displayNotificationWithMessage:(@"Leider greifen aktuell zu viele Nutzer auf die Bahnserver zu. Bitte erneut versuchen :)") forDuration:2.0f];
        }
        else
        {
            if ([dicinfo objectForKey:(@"ErrNum")])
            {
                CWStatusBarNotification *notification = [CWStatusBarNotification new];
                notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
                notification.multiline = true;
                [notification displayNotificationWithMessage:(@"Die API der Bahn hat keine Informationen zu diesem Bahnhof.") forDuration:2.0f];
            }
            if (![dicinfo objectForKey:(@"ErrNum")])
            {
                
            infoface.hidden = false;
            infoviewtable = [[InfoViewTable alloc]initWithFrame:infoface.frame style:UITableViewStylePlain];
            infoviewtable.parent_info_viewc = (id)self;
            
            [self.view addSubview:infoviewtable];
            [infoviewtable loadwithDictionary:dicinfo];
//            [UIView animateWithDuration:0.4
//                                  delay:0
//                                options:UIViewAnimationOptionCurveEaseIn
//                             animations:^ {
//                                 infoface.hidden = false;
//                                 
//                                 [self.view addSubview:infoface];
//                                 infoface.alpha = 0.1;
//                                 infoface.alpha = 1.0;
//                             }completion:^(BOOL finished) {
//                                 [infoface setupvithDictionary:dicinfo];
//                             }];
            }
        }
    });
    
}
-(void)hideInformationInterface
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [infoface removeFromSuperview];
        [UIView animateWithDuration:0.4
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^ {
                             infoface.frame = infoface.frame;
                             infoviewtable.alpha = 1.0;
                             infoviewtable.alpha = 0.1;
                             
//                             infoface.frame = CGRectMake(0, self.view.frame.size.height+self.view.frame.size.height, self.view.frame.size.width, infoface.frame.size.height);
                         }completion:^(BOOL finished) {
                             infoface.hidden = true;
                             infoviewtable.hidden = true;
                             
                         }];
    });
    
}

-(void)shownews
{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:(@"shownews1")])
    {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.backgroundType = SCLAlertViewBackgroundShadow;
    UIImage *logo = [UIImage imageNamed:(@"adamonly.png")];
    alert.tintTopCircle = true;
    alert.iconTintColor = [UIColor whiteColor];
    alert.viewText.textAlignment = NSTextAlignmentCenter;
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentCenter;
    
    alert.attributedFormatBlock = ^NSAttributedString* (NSString *value)
    {
        NSMutableAttributedString *subTitle = [[NSMutableAttributedString alloc]initWithString:value];
        
        NSRange bold1Range = [value rangeOfString:@"ADAM" options:NSRegularExpressionSearch];
        NSRange fullString = [value rangeOfString:subTitle.string options:NSCaseInsensitiveSearch];
        [subTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:fullString];
        return subTitle;
    };
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:(@"shownews1")];
        
    [alert showCustom:self image:logo color:[UIColor colorWithCSS:(@"#FE6500")] title:(@"Das Bahnhofs-Update") subTitle:(@"Du kannst mit ADAM jetzt Bahnhöfe ganz direkt suchen - und zu fast jedem Bahnhof zusätzliche Informationen erhalten. Und falls du mal kein Internet hast - ADAM funktioniert jetzt auch mit lokalen Datensätzen offline. Wir hoffen, dir gefällt das Update.") closeButtonTitle:(@"Verstanden") duration:0];
    }
    
    
}
// SPEICHERABBILD
-(void)statusbarmessage:(NSString*)string
{
    CWStatusBarNotification *notification = [CWStatusBarNotification new];
    [notification displayNotificationWithMessage:(@"Speicherabbild erstellt") forDuration:2.0f];
}
//SEARCHVIEW
-(void)addSearchView
{
    if (searchview)
    {
        searchview.hidden = NO;
    }
    if (!searchview)
    {
        searchview = [[SearchView alloc]initWithFrame:self.view.frame];
        searchview.parent_search = (id)self;
        [searchview setup];
        [self.view addSubview:searchview];
    }
}

@end
