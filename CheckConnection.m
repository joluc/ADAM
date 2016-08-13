//
//  CheckConnection.m
//  Veranstaltungskalender
//
//  Created by Praktikant on 01.02.16.
//  Copyright © 2016 Praktikant. All rights reserved.
//

#import "CheckConnection.h"
#import "Reachability.h"

@implementation CheckConnection
-(BOOL)checkfnc
{
    BOOL statusresult;
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        printf("\n Verbindung verfügbar.");
        return YES;
    }
    else {
        statusresult = NO;
    }
    printf("\n Es ist ein Fehler aufgetreten: \n Es ist keine Internetverbindung vorhanden.");
    
    return statusresult;
    
}

@end
