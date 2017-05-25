//
//  AppDelegate.h
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@import FirebaseRemoteConfig;


@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

 -(NSString *)applicationDocumentsDirectory;
@property (strong, nonatomic, readonly) NSPersistentContainer *persistentContainer;

@end

