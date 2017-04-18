//
//  SearchView.h
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 15.04.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"


@interface SearchView : UIView
-(void)setup;


@property UITableView *tableView;
@property ViewController *parent_search;


@end
