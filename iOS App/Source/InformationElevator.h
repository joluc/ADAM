//
//  InformationElevator.h
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 13.04.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationElevator : UIView
@property (weak, nonatomic) IBOutlet UILabel *bahnhof_name;
@property (weak, nonatomic) IBOutlet UIImageView *status_image;


-(id)initWithCoder:(NSCoder *)aDecoder;

@end
