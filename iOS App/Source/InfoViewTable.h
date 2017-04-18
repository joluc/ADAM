//
//  InfoViewTable.h
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 14.04.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Informationeninterface.h"
#import "ViewController.h"


@interface InfoViewTable : UITableView

-(void)loadwithDictionary:(NSMutableDictionary*)dic;

@property Informationeninterface *perant_info;
@property ViewController *parent_info_viewc;




@end
