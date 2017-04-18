//
//  NosAnnot.m
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 13.04.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import "NosAnnot.h"

@implementation NosAnnot

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
//    _infoView.hidden = YES;
}
-(void)buttonHandlerCallOut:(UIButton*)sender{
    NSLog(@"Annotation Clicked");
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView* v = [super hitTest:point withEvent:event];
    if (v != nil)
    {
        [self.superview bringSubviewToFront:self];
    }
    return v;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect rec = self.bounds;
    BOOL isIn = CGRectContainsPoint(rec, point);
    if(!isIn)
    {
        for (UIView *v in self.subviews)
        {
            isIn = CGRectContainsPoint(v.frame, point);
            if(isIn)
                break;
        }
    }
    return isIn;
}

@end
