//
//  NSArray+CostumKVOOperators.h
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 14.04.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CostumKVOOperators)
- (id) _firstForKeyPath: (NSString*) keyPath;

@end
