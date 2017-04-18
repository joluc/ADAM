//
//  UIFont+SystemFontOverride_h.m
//  Don't touch this.
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import "UIFont+SystemFontOverride_h.h"

@implementation UIFont (SystemFontOverride_h)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"AvenirNext-DemiBold" size:fontSize];
}

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"AvenirNext-Regular" size:fontSize];
    
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
}

#pragma clang diagnostic pop
@end
