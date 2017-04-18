//
//  UIFont+MoreFont.m
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 15.04.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import "UIFont+MoreFont.h"

@implementation UIFont (MoreFont)
- (UIFont *)UltraLightSystemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"AvenirNext-UltraLight" size:fontSize];
}
- (UIFont *)HeavySystemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"AvenirNext-Heavy" size:fontSize];
}

    //    AvenirNext-Bold
    //    AvenirNext-BoldItalic
    //    AvenirNext-DemiBold
    //    AvenirNext-DemiBoldItalic
    //    AvenirNext-Heavy
    //    AvenirNext-HeavyItalic
    //    AvenirNext-Italic
    //    AvenirNext-Medium
    //    AvenirNext-MediumItalic
    //    AvenirNext-Regular
    //    AvenirNext-UltraLight
    //    AvenirNext-UltraLightItalic
    
@end
