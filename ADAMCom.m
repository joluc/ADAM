//
//  ADAMCom.m
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import "ADAMCom.h"
#define URL @"https://adam.noncd.db.de/api/v1.0/facilities" //Hier ist die API der Bahn

@implementation ADAMCom
ADAMerci *merci;
///Gibt ein ADAMerci-Objekt zurück
-(ADAMerci*)dictionary_fromADAM
{
    NSURL *url=[NSURL URLWithString:URL];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSMutableDictionary *dicti;
    dicti = [self dicfromdata:urlData];
    
    
    NSMutableArray *equip = [dicti valueForKeyPath:@"equipmentnumber"];
    NSMutableArray *type = [dicti valueForKeyPath:@"type"];
    NSMutableArray *description = [dicti valueForKeyPath:(@"description")];
    NSMutableArray *geocoordX = [dicti valueForKeyPath:(@"geocoordX")];
    NSMutableArray *geocoordY = [dicti valueForKeyPath:(@"geocoordY")];
    NSMutableArray *state = [dicti valueForKeyPath:(@"state")];
    NSMutableArray *stationnumber = [dicti valueForKeyPath:(@"stationnumber")];
    
    
    // ADAMerci als Datasource mit den einzelnen Werten -
    // so umgehe ich das Problem mit den unbenannten Arrays!
    // Abgerufen wird das dann anhand von dem Index, der mit
    // der Equipmentnummer festgestellt wird
    
    merci = [[ADAMerci alloc]init];
    merci.equip = [equip mutableCopy];
    merci.type = [type mutableCopy];
    merci.description_ = [description mutableCopy];
    merci.geocoordX = [geocoordX mutableCopy];
    merci.geocoordY = [geocoordY mutableCopy];
    merci.state = [state mutableCopy];
    merci.stationnumber = [stationnumber mutableCopy];
    
    equip = nil;
    type = nil;
    description = nil;
    geocoordX = nil;
    geocoordY = nil;
    state = nil;
    stationnumber = nil;
    
    
//    7.590019933
//    50.358767133
//    AIzaSyAfN0znfkVve3HM5itywturlxOpF2Rl9FA KEY
//    https://maps.googleapis.com/maps/api/streetview?size=600x300&location=46.414382,10.013988&heading=151.78&pitch=-0.76&key=
    return merci;
    
}
-(NSMutableDictionary*)dicfromdata:(NSData*)responseData
{
    
    NSError* error;
    NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
//    NSLog(@"%@",json.description); // Encoding zu JSON Log
    
    return json;
}

@end
