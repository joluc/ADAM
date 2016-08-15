//
//  AppDelegate.m
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//


#import "AppDelegate.h"
#import "outrepasser.h"

// Hallo!
// Du darfst den Code von mir gerne benutzen...
// Aber bitte beachte die CCBYNC 4.0 Lizenz
// Kommerzielle Nutzung nur mit meiner ausdrücklichen Erlaubnis!
// Ich bin jederzeit unter jonathanlucas98@web.de erreichbar.
// Du bist auch immer willkommen hier mitzuhelfen.


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    nummerbahnnow = [[NSMutableDictionary alloc]init];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
+ (void)initialize {
    // Set user agent (the only problem is that we can't modify the User-Agent later in the program)
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:@"ADAM_by_Noscio_1.3", @"UserAgent", nil]; //Einen coolen User-Agent setzen
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    //only under MRC do we release [dictionnary release];
}

@end
