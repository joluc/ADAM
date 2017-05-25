//
//  TitleView_Aufzug.m
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Fritz on 18/05/2017.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import "TitleView_Aufzug.h"
#import <UIKit/UIKit.h>
#import "outrepasser.h"

@implementation TitleView_Aufzug
UIButton *report_fehler;

-(void)setup
{
    
    //DRAW
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*4/5)];
    _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.frame.size.height-self.frame.size.height*1/5)-10, self.frame.size.width, self.frame.size.height*1/5)];
    
    _titleLabel.font = [UIFont systemFontOfSize:self.frame.size.width/20];
    _subTitleLabel.font = [UIFont boldSystemFontOfSize:self.frame.size.width/30];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    _subTitleLabel.numberOfLines = 0;
    _titleLabel.numberOfLines = 0;
    
    [self addSubview:_titleLabel];
    [self addSubview:_subTitleLabel];
    _subTitleLabel.text = (@"Hier klicken, um eine Korrektur vorzuschlagen.");
    
    // Configure Text
    
    _subTitleLabel.textColor = [UIColor blackColor];
    _titleLabel.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    
    report_fehler = [[UIButton alloc] initWithFrame:self.frame];
    
    [self addSubview:report_fehler];
    
    [report_fehler addTarget:self action:@selector(report) forControlEvents:UIControlEventPrimaryActionTriggered];
    
}
-(void)report
{
    // SEND NOTIFICATION
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"TRIGGER_REPORT"
     object:self];
    
}
@end
