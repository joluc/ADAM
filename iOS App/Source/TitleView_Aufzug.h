//
//  TitleView_Aufzug.h
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Fritz on 18/05/2017.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"


@interface TitleView_Aufzug : UIView

-(void)setup;

@property UILabel *titleLabel;
@property UILabel *subTitleLabel;
@property ViewController *parent_viewController;


@end
