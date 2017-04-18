//
//  UIColor+EHColorAdditions.h
//  jReader
//
//  Created by Danila Gusev on 03/12/15.
//  Copyright © 2015 Danila Gusev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (EHColorAdditions)

/*!
 * @brief Get int value for color
 */
- (NSInteger)getHexColor;

/*!
 * @brief Create color with hex value. F.e. [UIColor colorWithHex:0x123ABC]
 */
+ (UIColor *)colorWithHex:(NSInteger)intColor;
@end
