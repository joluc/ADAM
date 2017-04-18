//
//  NSDictionary+NullReplacement.h
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 16.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullReplacement)

- (NSDictionary *)dictionaryByReplacingNullsWithBlanks;

@end
