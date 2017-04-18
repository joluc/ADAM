//
//  ViewController.h
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CWStatusBarNotification.h>
#import "ADAMCom.h"
@class ADAM_MapView;




@interface ViewController : UIViewController
{
    CLLocationManager *locationManager;
    
    
}

@property UIActivityIndicatorView *loadingindicator;
@property IBOutlet UIImageView *imageviewback;
@property UIButton *datenschutz;
@property UIButton *credits;
@property UIButton *ortung;
@property CWStatusBarNotification *notification;
@property ADAMCom *com;
@property UINavigationBar *navbar;
@property ADAM_MapView *mapView;



<<<<<<< Updated upstream
=======

-(void)hideInformationInterface;
-(void)statusbarmessage:(NSString*)string;
>>>>>>> Stashed changes
-(void)presentMessagewithexit:(NSString*)message;
-(void)ortme;
-(void)activateloader;
-(void)deactivateloader;
-(void)displayingInformationInterface:(NSMutableDictionary*)dicinfo;
-(void)hidenavbar;
-(void)shownavbar;


@end

