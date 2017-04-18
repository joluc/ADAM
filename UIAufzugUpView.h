//
//  UIAufzugUpView.h
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 15.04.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAufzugUpView : UIView
@property (retain, nonatomic) UILabel *aufzug_message;

-(void)setupit;
-(void)setText:(NSString*)string;

@end
