//
//  ViewController.h
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController
{
    CLLocationManager *locationManager;
    
    
}
@property UIActivityIndicatorView *loadingindicator;
@property IBOutlet UIImageView *imageviewback;
@property UIButton *datenschutz;

-(void)activateloader;
-(void)deactivateloader;

@end

