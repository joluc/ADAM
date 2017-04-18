//
//  NosFrame.h
//  NosFrame
//
//  Created by Jonathan Lucas Fritz on 15.11.15.
//  Copyright © 2015 NOSCIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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
@interface NosFrame : NSObject
{
    CGRect frame;
    BOOL log;
    ///Deeplogging lässt sich NICHT mit rectwith... ...logging:NO deaktivieren
    BOOL deeplogging;
}

/**
 *  @author         Jonathan Fritz
 *  @version        0.1
 *  @since          0.1
 *  Diese Methode ruft das gewünschte CGRect ab
 *
 *  @param (int)option: Die Definitionsnummer
 *  @param (UIView*)main: View worauf die CGRect errechnet werden sollen
 *  @param (BOOL)logging: Ich denke du weißt was das ist. Es gibt aber eigentlich keinen Grund das irgendwie zu aktivieren.
 *
 *  @return Eine CGRect mit vorbestimmten Maßen, aber angepasst an das Main
 */
-(CGRect)rectwith:(int)option andenablelogging:(BOOL)logging;
///Deeplogging lässt sich NICHT mit rectwith... ...logging:NO deaktivieren
-(void)enabledeeplogging;
///Deeplogging lässt sich NICHT mit rectwith... ...logging:NO aktivieren
-(void)disabledeeplogging;
@property (nonatomic, retain) UIView *main;


@end

