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

@interface ViewController ()<CLLocationManagerDelegate>

@end
UIButton *credits;
ADAM_MapView *mapView;
NSMutableDictionary *dictim;
NSMutableArray *nummerext;
NSMutableArray *stationlong;
NSMutableDictionary *nummerbahn;
ADAMerci *baguette;
MBProgressHUD *hud;

@implementation ViewController
@synthesize datenschutz;


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    [self startupcheck];
}
-(void)startupcheck
{
    CheckConnection *checker;
    checker = [[CheckConnection alloc]init];
    
    if ([checker checkfnc])
    {
        [self runner];
        
    }
    if (![checker checkfnc])
    {
        
        NSTimer *timernew; // Kurzes Delay, dass sich das UI updaten kann
        timernew = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(run_error) userInfo:nil repeats:NO];
    }
}
-(void)runner
{
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    credits = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 10)];
    [credits setBackgroundColor:[UIColor clearColor]];
    [credits.titleLabel setFont:[UIFont systemFontOfSize:self.view.frame.size.height/55]];
    [credits setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [credits setTitle:(@"Daten bereitgestellt von der Deutschen Bahn / ADAM") forState:UIControlStateNormal];
    
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.text = (@"Lade Daten vom Server...");
    
    
    NSTimer *timernew; // Kurzes Delay, dass sich das UI updaten kann
    timernew = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(run_debut) userInfo:nil repeats:NO];
    NSTimer *timernewnew; // Kurzes Delay, dass sich das UI updaten kann
    timernewnew = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(testanother) userInfo:nil repeats:NO];
    
//    http://www.bahnhof.de/bahnhof-de/Lorch__Wuertt_.html?hl=lorch
}
-(void)testanother
{
    NSString *urlstring;
    urlstring = (@"https://noscio.eu/ADAM/stationsdaten.json");
    
    NSURL *url=[NSURL URLWithString:urlstring];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    dictim = [self dicfromdata:urlData];
    fullele = [dictim mutableCopy];
    
    nummerext = [dictim valueForKeyPath:@"Equipment"];
    stationlong = [dictim valueForKeyPath:@"Ort"];
    
    nummerbahn = [NSMutableDictionary new];
    int dreii = 0;
    if (!error)
    {
        hud.detailsLabel.text = (@"Verarbeitung...");
    }
    for (NSString *key in nummerext) {
        NSString *realkey;
        realkey = [NSString stringWithFormat:@"%lld", key.longLongValue];
        
        [nummerbahn setValue:[stationlong objectAtIndex:dreii] forKey:realkey];
        dreii++;
    }
    
    NSLog(@"%@", nummerbahn);
    
    nummerbahnnow = [nummerbahn mutableCopy];
    
}
-(NSMutableDictionary*)dicfromdata:(NSData*)responseData
{
    
    NSError* error;
    NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSLog(@"%@",json.description);
    
    return json;
}
-(void)run_error
{
    UIAlertController *control;
    control = [UIAlertController alertControllerWithTitle:(@"Keine Verbindung") message:(@"Die Daten können nicht abgerufen werden. Es besteht keine aktive Verbindung zum Internet") preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Erneut versuchen"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self startupcheck];
                         }];
    [control addAction:ok];
    
    
    [self presentViewController:control animated:YES completion:nil];
}
-(void)run_debut
{
    _loadingindicator = [[UIActivityIndicatorView alloc]initWithFrame:self.view.frame];
    [self activateloader];
    
    ADAMCom *com;
    com = [[ADAMCom alloc]init];
    
    
    baguette = [[ADAMerci alloc]init];
    baguette = [com dictionary_fromADAM];
    
    NSMutableDictionary *dictionary1;
    dictionary1 = [baguette dicforindex:2];
    NSLog(@"%@",dictionary1.description);
    
    
    mapView = [[ADAM_MapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:mapView];
    mapView.viewc = (id)self;
    mapView.fromage = baguette;
    
    [self.view addSubview:mapView];
    
    [mapView setup];
    [self.view addSubview:credits];
    
    datenschutz = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-self.view.frame.size.width/5, self.view.frame.size.height-15,self.view.frame.size.width/5, 10)];
    
    
    datenschutz.titleLabel.textAlignment = NSTextAlignmentRight;
    [datenschutz setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [datenschutz addTarget:self action:@selector(showprivacy) forControlEvents:UIControlEventPrimaryActionTriggered];
    [datenschutz setTitle:(@"Datenschutz") forState:UIControlStateNormal];
    [datenschutz.titleLabel setFont:[UIFont systemFontOfSize:self.view.frame.size.height/56]];
    [datenschutz setBackgroundColor:[UIColor whiteColor]];
    
//    [self.view addSubview:datenschutz];
    
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:(@"privacy2")])
    {
        [self showprivacy];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:(@"privacy2")];
    }
    UIButton *ortung;
//    ortung = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-self.view.frame.size.width/10, self.view.frame.size.height-(35+self.view.frame.size.width/15),self.view.frame.size.width/10, self.view.frame.size.width/10)];
    ortung = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, self.view.frame.size.height-50,50, 50)];
    
    [ortung setImage:[UIImage imageNamed:(@"smalladam.png")] forState:UIControlStateNormal];
    [self.view addSubview:ortung];
    ortung.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [ortung addTarget:self action:@selector(ortme) forControlEvents:UIControlEventPrimaryActionTriggered];
    
}
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
-(void)showprivacy
{
    UIAlertController *priv;
    priv = [UIAlertController alertControllerWithTitle:(@"Datenschutz") message:(@"Deine Privatsphäre ist uns sehr wichtig. Deshalb stellt die App zu keinem Zeitpunkt eine Verbindung mit den Servern von Noscio her. Die Deutsche Bahn erhält möglicherweise bei dem Abrufen der Daten von ADAM Informationen darüber, welches Gerät du verwendest und wann du auf ADAM zugreifst. Dein Standort wird aber nicht übermittelt. Mit der Nutzung der App erklärst du dich mit diesen Bedingungen einverstanden.") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okay;
    okay = [UIAlertAction actionWithTitle:(@"In Ordnung") style:UIAlertActionStyleDefault handler:nil];
    [priv addAction:okay];
    [self presentViewController:priv animated:YES completion:nil];
    
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
-(MKAnnotationView*) returnPointView: (CLLocationCoordinate2D) location andTitle: (NSString*) title andColor: (int) color{
    /*Method that acts as a point-generating machine. Takes the parameters of the location, the title, and the color of the
     pin, and it returns a view that holds the pin with those specified details*/
    
    printf("\n Working");
    
    
    MKPointAnnotation *resultPin = [[MKPointAnnotation alloc] init];
    MKPinAnnotationView *result = [[MKPinAnnotationView alloc] initWithAnnotation:resultPin reuseIdentifier:Nil];
    [resultPin setCoordinate:location];
    resultPin.title = title;
    result.pinTintColor = [UIColor greenColor];
    
    return result;
    
}

-(void)activateloader
{
    
}
-(void)deactivateloader
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
