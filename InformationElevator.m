//
//  InformationElevator.m
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 13.04.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import "InformationElevator.h"

@implementation InformationElevator

-(InformationElevator *) init{
    InformationElevator *result = nil;
    NSArray* elements = [[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner:self options: nil];
    for (id anObject in elements)
    {
        if ([anObject isKindOfClass:[self class]])
        {
            result = anObject;
            break;
        }
    }
    return result;
}

@end
