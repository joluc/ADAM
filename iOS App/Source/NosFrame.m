//
//  NosFrame.m
//  NosFrame
//
//  Created by Jonathan Lucas Fritz on 15.11.15.
//  Copyright © 2015 NOSCIO. All rights reserved.
//

#import "NosFrame.h"

@implementation NosFrame
@synthesize main;
///1 Ganzer Bildschirm
///2 Obere Hälfte
///3 Untere Hälfte
///4 Obere dritte Hälfte
///5 Mittlere dritte Hälfte
///6 Untere dritte Hälfte
///7 Zurück Knopf
///8 Top Bar
///9 Bottom Bar
///10 View bei Top Bar
///11 View bei Bottom Bar
///12 Bildschirmhälfte rechts
///13 Bildschirmhälfte links
///14 Halber Bildschirm in Mitte des Bildschirms
-(CGRect)rectwith:(int)option andenablelogging:(BOOL)logging
{
    log = logging;
    [self logthat:(@"Logging wurde bei diesem Durchlauf aktiviert!")];
    
    NSString *defnum;
    defnum = (@"");
    defnum = [defnum stringByAppendingString:(@"Die Definitionsnummer ist wohl ganz offensichtlich ")];
    defnum = [defnum stringByAppendingString:[NSString stringWithFormat:@"%d", option]];
    
    int rand;
    rand = arc4random()%10;
    if (rand == 2)
    {
        defnum = [defnum stringByAppendingString:(@"... Wie kann eine Nummer unsympathisch sein?!")];
    }
    
    [self logthat:defnum];
    if (option == 1)
    {
        frame = CGRectMake(0, 0, main.frame.size.width, main.frame.size.height);
        [self printdeeplog:frame];
        return frame;
    }
    
    if (option == 2)
    {
        frame = CGRectMake(0, 0, main.frame.size.width, main.frame.size.height/2);
        [self printdeeplog:frame];
        return frame;
    }
    
    if (option == 3)
    {
        frame = CGRectMake(0, main.frame.size.height/2, main.frame.size.width, main.frame.size.height/2);
        [self printdeeplog:frame];
        return frame;
    }
    if (option == 4)
    {
        frame = CGRectMake(0, 0,main.frame.size.width, main.frame.size.height/3);
        [self printdeeplog:frame];
        return frame;
    }
    if (option == 5)
    {
        frame = CGRectMake(0, (main.frame.size.height/3),main.frame.size.width, main.frame.size.height/3);
        [self printdeeplog:frame];
        return frame;
    }
    if (option == 6)
    {
        frame = CGRectMake(0,(main.frame.size.height)-(main.frame.size.height/3),main.frame.size.width, main.frame.size.height/3);
        [self printdeeplog:frame];
        return frame;
    }
    if (option == 7)
    {
        frame = CGRectMake(10, 10, 100, 40);
        [self printdeeplog:frame];
        return frame;
    }
    if (option == 8)
    {
        frame = CGRectMake(0, 0, main.frame.size.width, 75);
        [self printdeeplog:frame];
        return frame;
    }
    if (option == 9)
    {
        frame = CGRectMake(0, main.frame.size.height-75, main.frame.size.width, 75);
        [self printdeeplog:frame];
        return frame;
    }
    if (option == 10)
    {
        frame = CGRectMake(0, 75, main.frame.size.width, main.frame.size.height-75);
        [self printdeeplog:frame];
        return frame;
    }
    if (option == 11)
    {
        frame = CGRectMake(0, 0, main.frame.size.width, main.frame.size.height-75);
        [self printdeeplog:frame];
        return frame;
    }
    if (option == 12)
    {
        frame = CGRectMake(0, 0, main.frame.size.width/2, main.frame.size.height);
        [self printdeeplog:frame];
        return frame;
    }
    if (option == 13)
    {
        frame = CGRectMake(main.frame.size.width/2, 0, main.frame.size.width/2, main.frame.size.height);
        [self printdeeplog:frame];
        return frame;
    }
    if (option == 14)
    {
        frame = CGRectMake(0, (main.frame.size.height/3),main.frame.size.width, main.frame.size.height/2);
        [self printdeeplog:frame];
        return frame;
    }
    if (option == 3141)
    {
        [self logthat:(@"Nein, einfach nein.")];
        return frame;
    }
    
    [self logthat:(@"Diese Nummer gibt es nichtmal. Entweder hast du nicht aufgepasst oder willst was ausprobieren. ERROR! \n Interessant Aussehender Errorbericht: NEIN")];
    
    return frame;
}
-(void)printdeeplog:(CGRect)frame2
{
    if (deeplogging == YES)
    {
    int w;
    int h;
    int x;
    int y;
    
    w = frame.size.width;
    h = frame.size.height;
    x = frame.origin.x;
    y = frame.origin.y;
    
    printf("\n Frame mit der Breite %d, Höhe %d erstellt und auf die Koordinaten %d(x) und %d(y) gesetzt",w,h,x,y);
    }
    
    
}
-(void)enabledeeplogging
{
    deeplogging = YES;
}
-(void)disabledeeplogging
{
    deeplogging = NO;
}
-(void)logthat:(NSString*)text
{
    if (log == YES)
    {
        NSDate *currentTime = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh-mm"];
        NSString *resultString = [dateFormatter stringFromDate: currentTime];
        
        NSString *stringprefix;
        stringprefix = (@"\n");
        stringprefix = [stringprefix stringByAppendingString:resultString];
        stringprefix = [stringprefix stringByAppendingString:(@" | [NosFrame]:")]; /*Einfach weil es mit eckigen Klammern cooler aussieht. Oh ein unnötiger Kommentar!*/
        NSString *full;
        full = (@"");
        full = [full stringByAppendingString:stringprefix];
        full = [full stringByAppendingString:text];
        printf("%s",[full UTF8String]);
    }
}



@end
