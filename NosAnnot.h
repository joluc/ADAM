//
//  NosAnnot.h
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 13.04.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "InformationElevator.h"


@interface NosAnnot : MKAnnotationView
@property (strong, nonatomic) InformationElevator *infoView;
@property (strong, nonatomic) NSString *stationID;


- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
-(void)setup;


@end
