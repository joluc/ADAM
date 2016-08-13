//
//  ADAMCom.m
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import "ADAMCom.h"
#define URL @"https://adam.noncd.db.de/api/v1.0/facilities"

@implementation ADAMCom
ADAMerci *merci;
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
    // Abgerufen werden dann die Geocoordinaten
    
    merci = [[ADAMerci alloc]init];
    merci.equip = [equip mutableCopy];
    merci.type = [type mutableCopy];
    merci.description_ = [description mutableCopy];
    merci.geocoordX = [geocoordX mutableCopy];
    merci.geocoordY = [geocoordY mutableCopy];
    merci.state = [state mutableCopy];
    merci.stationnumber = [stationnumber mutableCopy];
    
    return merci;
    
}
-(NSMutableDictionary*)dicfromdata:(NSData*)responseData
{
    
    NSError* error;
    NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSLog(@"%@",json.description);
    
    return json;
}

@end
