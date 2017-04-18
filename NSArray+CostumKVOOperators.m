//
//  NSArray+CostumKVOOperators.m
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 14.04.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import "NSArray+CostumKVOOperators.h"

@implementation NSArray (CustomKVOOperators)

- (id) _firstForKeyPath: (NSString*) keyPath {
    NSArray* array = [self valueForKeyPath: keyPath];
    if( [array respondsToSelector: @selector(objectAtIndex:)] &&
       [array respondsToSelector: @selector(count)]) {
        if( [array count] )
            return [array objectAtIndex: 0];
        else
            return nil;
    }
    else {
        return nil;
    }
}

@end
