//
//  ViewDownInterface.m
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 14.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import "ViewDownInterface.h"
#import "NosFrame.h"
#import "outrepasser.h"
#import "Reachability.h"
<<<<<<< Updated upstream
=======
#import "Informationeninterface.h"
#import "UIFont+MoreFont.h"

>>>>>>> Stashed changes

//ist eigentlich alles selbsterklärend.
@implementation ViewDownInterface
NosFrame *framer;
UILabel *bigg;
UILabel *small;

UIImageView *imageview;
UIActivityIndicatorView *loadingimage;
int smallbigg_diff;
MKPointAnnotation *annotation_bahnhof;



int actindex;
@synthesize HUD2;

-(void)setup
{
    printf("\n SETUP SMALLER");
    
    framer = [[NosFrame alloc]init];
    framer.main = self;
    
    
}
-(void)swipeup
{
    
    
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
-(void)sethiddennow
{
    [self.mapviewadam.map removeAnnotation:annotation_bahnhof];
    [self.mapviewadam.viewc hideInformationInterface];
    [bigg removeFromSuperview];
    [imageview removeFromSuperview];
    [loadingimage removeFromSuperview];
    self.hidden = YES;
    framer = nil;
    
<<<<<<< Updated upstream
=======
}
-(void)loadforName:(NSString *)name
{
    small = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-smallbigg_diff, self.frame.size.width, smallbigg_diff)];
    small.textColor = [UIColor lightTextColor];
    [self addSubview:small];
    small.backgroundColor = [UIColor blackColor];
    
    NSString *nameofstation_;
    nameofstation_ = (@"Name: ");
    bigg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-smallbigg_diff)];
    [bigg setFont:[self mediumfont:self.frame.size.height/4]];
    bigg.textAlignment = NSTextAlignmentCenter;
    
    [self dispatch_stationNameOnlyStation:name];
>>>>>>> Stashed changes
}
-(void)loadforID:(NSString *)ID
{
    smallbigg_diff = 22;
    
    self.hidden = NO;
//    https://adam.noncd.db.de/api/v1.0/stations/27
    
//    NSString *number;
//    number = [self typeforquipmentnumber:ID];
//    NSLog(@"%@",number);
    self.backgroundColor = [UIColor whiteColor];
    
    
//    if ([ID containsString:(@"Aufzug")])
//    {
//    clean = [ID stringByReplacingOccurrencesOfString:(@"Aufzug bei Station: ") withString:(@"")];
//    }
//    if ([ID containsString:(@"Rolltreppe")])
//    {
//        clean = [ID stringByReplacingOccurrencesOfString:(@"Rolltreppe bei Station: ") withString:(@"")];
//    }
//    
//    NSLog(@"%@",ID);
    [self swipeup];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self typeforquipmentnumber:ID];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self animateupinfofield];
    });
    
}
-(void)animateupinfofield
{

}
- (UIFont *)UltraLightSystemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"AvenirNext-UltraLight" size:fontSize];
}
- (UIFont *)HeavySystemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"AvenirNext-Heavy" size:fontSize];
}
- (UIFont *)mediumfont:(CGFloat)fontSize {
    return [UIFont fontWithName:@"AvenirNext-DemiBold" size:fontSize];
}
//    AvenirNext-Bold
//    AvenirNext-BoldItalic
//    AvenirNext-DemiBold
//    AvenirNext-DemiBoldItalic
//    AvenirNext-Heavy
//    AvenirNext-HeavyItalic
//    AvenirNext-Italic
//    AvenirNext-Medium
//    AvenirNext-MediumItalic
//    AvenirNext-Regular
//    AvenirNext-UltraLight
//    AvenirNext-UltraLightItalic
-(void)typeforquipmentnumber:(NSString*)ID
{
<<<<<<< Updated upstream
    NSString *nameofstation_;
    nameofstation_ = (@"Name: ");
    
//    https://adam.noncd.db.de/api/v1.0/stations/27
//    NSString *urlstring;
//    urlstring = (@"https://adam.noncd.db.de/api/v1.0/stations/");
//    urlstring = [urlstring stringByAppendingString:ID];
//    
//    NSURL *url=[NSURL URLWithString:urlstring];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:url];
//    [request setHTTPMethod:@"GET"];
//    
//    NSError *error;
//    NSURLResponse *response;
//    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSMutableDictionary *dicti;
//    dicti = [self dicfromdata:urlData];
//    
//    NSString *nameders;
//    nameders = [dicti valueForKey:(@"name")];
    
//    nameofstation_ = [self.bonjour.stationnumberfornames valueForKey:ID];
//    NSLog(@"%@",self.bonjour.stationnumberfornames.description);
//    
    
    imageview = [[UIImageView alloc]initWithFrame:self.frame];
    [self.mapviewadam addSubview:imageview];
    
    
    
    bigg = [[UILabel alloc]initWithFrame:self.frame];
    [bigg setFont:[UIFont boldSystemFontOfSize:self.frame.size.height/4]];
    bigg.textAlignment = NSTextAlignmentCenter;
    if ([nummerbahnnow valueForKey:ID])
    {
        bigg.text = [nummerbahnnow valueForKey:ID];
    }
    bigg.numberOfLines = 2;
    bigg.alpha = 0.8;
=======
    dispatch_async(dispatch_get_main_queue(), ^{
        small = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-smallbigg_diff, self.frame.size.width, smallbigg_diff)];
        small.textColor = [UIColor lightTextColor];
        [self addSubview:small];
        small.backgroundColor = [UIColor blackColor];
        
        NSString *nameofstation_;
        nameofstation_ = (@"Name: ");
        
        bigg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-smallbigg_diff)];
        [bigg setFont:[self mediumfont:self.frame.size.height/4]];
        
        bigg.textAlignment = NSTextAlignmentCenter;
        BOOL makeitdifferent;
        makeitdifferent = false;
        
        if (![nummerbahnnow valueForKey:ID])
        {
            makeitdifferent = true;
            
            CWStatusBarNotification *newnot = [CWStatusBarNotification new];
            self.mapviewadam.viewc.notification = newnot;
            self.mapviewadam.viewc.notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
            self.mapviewadam.viewc.notification.multiline = true;
            self.mapviewadam.viewc.notification.notificationTappedBlock = ^(){
                printf("/n Tapped");
            };
            [self.mapviewadam.viewc.notification displayNotificationWithMessage:(@"Fehlerhafter Datensatz. Versuche, fehlende Informationen zu rekonstruieren...")completion:^(){
                printf("\n Processing...");
                
                HUD2 = [MBProgressHUD showHUDAddedTo:self.mapviewadam.viewc.view animated:true];
                HUD2.detailsLabel.text = (@"Rekonstruktion läuft...");
                
                [UIView animateWithDuration:0.5
                                      delay:0.1
                                    options: UIViewAnimationOptionCurveEaseOut
                                 animations:^
                 {
                     self.mapviewadam.alpha = 0.6;
                     self.mapviewadam.viewc.imageviewback.hidden = NO;
                     
                 }completion:^(BOOL finished)
                 {
                     NSLog(@"STATIONSID: %@",[self.mapviewadam.stationID_equipID objectForKey:ID]);
                     
                     NSString *getStationName = [_adamcom_instance getStationNameforStationID:[self.mapviewadam.stationID_equipID objectForKey:ID]];
                     if (getStationName)
                     {
                         [MBProgressHUD hideHUDForView:self.mapviewadam.viewc.view animated:true];
                         [UIView animateWithDuration:0.2
                                               delay:2.1
                                             options: UIViewAnimationOptionCurveEaseOut
                                          animations:^
                          {
                              self.mapviewadam.alpha = 1.0;
                              self.mapviewadam.viewc.imageviewback.hidden = YES;
                          }completion:^(BOOL finished)
                          {
                              [self dispatch_stationName:getStationName];
                              [newnot dismissNotification];
                              [newnot displayNotificationWithMessage:(@"Information möglicherweise fehlerhaft.") forDuration:2]; // Da FaSta aktuell Probleme macht...
                          }];
                     }
                     if (!getStationName)
                     {
                         [MBProgressHUD hideHUDForView:self.mapviewadam.viewc.view animated:true];
                         [UIView animateWithDuration:0.2
                                               delay:2.1
                                             options: UIViewAnimationOptionCurveEaseOut
                                          animations:^
                          {
                              self.mapviewadam.alpha = 1.0;
                              self.mapviewadam.viewc.imageviewback.hidden = YES;
                          }completion:^(BOOL finished)
                          {
                              [newnot dismissNotification];
                              [newnot displayNotificationWithMessage:(@"Konnte fehlende Informationen nicht laden.") forDuration:2];
                          }];
                     }
                 }];
                
            }];
            
        }
        if ([nummerbahnnow valueForKey:ID])
        {
            bigg.text = [nummerbahnnow valueForKey:ID];
            [self dispatch_stationName:bigg.text];
        }
        
    });
//    NSLog(@"%@",nameofstation_);
}
-(void)preLoad:(NSString*)name
{
    dispatch_async(dispatch_get_main_queue(), ^{
        small = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-smallbigg_diff, self.frame.size.width, smallbigg_diff)];
        small.textColor = [UIColor lightTextColor];
        [self addSubview:small];
        small.backgroundColor = [UIColor blackColor];
        
        bigg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-smallbigg_diff)];
        [bigg setFont:[self mediumfont:self.frame.size.height/4]];
        bigg.textAlignment = NSTextAlignmentCenter;
        BOOL makeitdifferent;
        makeitdifferent = false;
        [self dispatch_stationNameOnlyStation:name];
    });
}

-(void)dispatch_stationNameOnlyStation:(NSString*)name
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (name)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                bigg.text = name;
            });
            NSMutableDictionary *moreInformationaboutStation;
            moreInformationaboutStation = [_adamcom_instance getStationInformationwithName:name];
            NSString *validation;
            validation = name;
            if (moreInformationaboutStation)
            {
                NSMutableArray *coordsdic;
                NSMutableArray *arrayCoordinner;
                NSMutableArray *arrayCoordinnerinner;
                CLLocationCoordinate2D coordinate;
                MKPlacemark *placeMark;
                
                placeMark = [[MKPlacemark alloc]initWithCoordinate:coordinate postalAddress:nil];
                [self.mapviewadam.map addAnnotation:placeMark];
                
                // Was für ein Aufwand... :/
                coordsdic = [moreInformationaboutStation valueForKeyPath:(@"geoCoords.coordinates")];
                arrayCoordinner = coordsdic.firstObject;
                arrayCoordinnerinner = arrayCoordinner.firstObject;
                NSLog(@"FIRST OBJECT : %@",arrayCoordinnerinner.firstObject);
                if (arrayCoordinnerinner.count == 2)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        printf("\n Trying to add Annotation");
                    });
                }
                
                [self.mapviewadam.viewc displayingInformationInterface:moreInformationaboutStation];
            }
            
            if (validation)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    small.text = (@"Zusätzliche Informationen zum Bahnhof geladen");
                    if (_adamcom_instance.loadLocal)
                    {
                        small.text = (@"Im lokalen Datensatz können keine Zusatzinformationen geladen werden.");
                        small.numberOfLines = 0;
                    }
                });
            }
            if (!validation)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    small.text = (@"Laden zusätzlicher Informationen nicht möglich.");
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                small.font = [UIFont boldSystemFontOfSize:12];
                small.textAlignment = NSTextAlignmentCenter;
                
            });
        }
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        bigg.numberOfLines = 2;
        bigg.alpha = 0.8;
        bigg.backgroundColor = [UIColor whiteColor];
        [self addSubview:bigg];
    });
>>>>>>> Stashed changes
    
}

-(void)dispatch_stationName:(NSString*)name
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (name)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                bigg.text = name;
            });
            NSMutableDictionary *moreInformationaboutStation;
            moreInformationaboutStation = [_adamcom_instance getStationInformationwithName:name];
            
            if (moreInformationaboutStation)
            {
                NSMutableArray *coordsdic;
                NSMutableArray *arrayCoordinner;
                NSMutableArray *arrayCoordinnerinner;
                CLLocationCoordinate2D coordinate;
                
                // Was für ein Aufwand... :/
                coordsdic = [moreInformationaboutStation valueForKeyPath:(@"geoCoords.coordinates")];
                arrayCoordinner = coordsdic.firstObject;
                arrayCoordinnerinner = arrayCoordinner.firstObject;
                NSLog(@"FIRST OBJECT : %@",arrayCoordinnerinner.firstObject);
                if (arrayCoordinnerinner.count == 2)
                {
                    float latf = [arrayCoordinnerinner[0] floatValue];
                    float lonf = [arrayCoordinnerinner[1] floatValue];
                    CLLocationDegrees lat = latf;
                    CLLocationDegrees lon = lonf;
                    coordinate = CLLocationCoordinate2DMake(lon, lat);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        printf("\n Trying to add Annotation");
                        annotation_bahnhof = [[MKPointAnnotation alloc] init];
                        [annotation_bahnhof setCoordinate:coordinate];
                        [annotation_bahnhof setTitle:name]; //You can set the subtitle too
//                        [self.mapviewadam.map addAnnotation:annotation_bahnhof];
                        
                        MKPlacemark *placeMark;
                        NSString *stadtundstreet;
                        stadtundstreet = [moreInformationaboutStation valueForKey:(@"adresse.city.@firstObject")];
                        
                        placeMark = [[MKPlacemark alloc]initWithCoordinate:coordinate postalAddress:(CNPostalAddress*)stadtundstreet];
                        [self.mapviewadam.map addAnnotation:placeMark];
                        
                    });
                }
                
                
                [self.mapviewadam.viewc displayingInformationInterface:moreInformationaboutStation];
            }
            
            if (name)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    small.text = (@"Zusätzliche Informationen zum Bahnhof geladen");
                });
            }
            if (!name)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    small.text = (@"Laden zusätzlicher Informationen nicht möglich.");
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                small.font = [UIFont boldSystemFontOfSize:12];
                small.textAlignment = NSTextAlignmentCenter;
                
            });
        }
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        bigg.numberOfLines = 2;
        bigg.alpha = 0.8;
        bigg.backgroundColor = [UIColor whiteColor];
        [self addSubview:bigg];
    });

}
-(void)setimageurl:(NSString *)url
{
    
            NSLog(@"The internet is working via WIFI.");
            loadingimage = [[UIActivityIndicatorView alloc]initWithFrame:self.frame];
            loadingimage.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            loadingimage.backgroundColor = [UIColor whiteColor];
            [self.mapviewadam addSubview:loadingimage];
            [loadingimage startAnimating];
            [self loadImage:[NSURL URLWithString:url]];
}
- (void)loadImage:(NSURL *)imageURL
{
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(requestRemoteImage:)
                                        object:imageURL];
    [queue addOperation:operation];
}

- (void)requestRemoteImage:(NSURL *)imageURL
{
    NSLog(@"%@",imageURL.absoluteString);
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    [self performSelectorOnMainThread:@selector(placeImageInUI:) withObject:image waitUntilDone:NO];
    
}

- (void)placeImageInUI:(UIImage *)image
{
    if (![self image:[UIImage imageNamed:(@"streetview-1.jpeg")] isEqualTo:image])
    {
    [imageview setImage:image];
    imageview.contentMode = UIViewContentModeScaleToFill;
        [loadingimage stopAnimating];
        [loadingimage removeFromSuperview];
        loadingimage = nil;
    }
    else
    {
        printf("\n Image is same.");
        imageview.image = nil;
        imageview = nil;
        [loadingimage stopAnimating];
        [loadingimage removeFromSuperview];
        loadingimage = nil;
    }
}
- (BOOL)image:(UIImage *)image1 isEqualTo:(UIImage *)image2
{
    NSData *data1 = UIImagePNGRepresentation(image1);
    NSData *data2 = UIImagePNGRepresentation(image2);
    
    return [data1 isEqual:data2];
}
-(NSMutableDictionary*)dicfromdata:(NSData*)responseData
{
    
    NSError* error;
    NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
//    NSLog(@"%@",json.description);
    
    return json;
}
-(void)willRemoveSubview:(UIView *)subview
{
    printf("\n GETTING REMOVED");
}

@end
