//
//  ADAMCom.h
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADAMerci.h"
@class ViewController;

@interface ADAMCom : NSObject
-(ADAMerci*)dictionary_fromADAM;

@property BOOL old_api;
@property BOOL loadLocal;

@property ViewController *parent_viewcontroller;
@property NSMutableDictionary *station_coords;

-(NSMutableDictionary*)getStationInformation:(NSString*)stationID;
-(NSMutableDictionary*)getStationInformationwithName:(NSString*)stationName; 
-(NSString*)getStationNameforStationID:(NSString*)equip; // ROLLTREPPE

-(void)setup;


-(ADAMerci*)loadLatest;


@end
