//
//  ADAMCom.m
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import "ADAMCom.h"
#import "NSDictionary+NullReplacement.h"
#import "NSArray+NullReplacement.h"
#import "EHPlainAlert.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>

//#define URL @"https://adam.noncd.db.de/api/v1.0/facilities" //Hier ist die alte API der Bahn
#define APIKEY @"CENSORED"
#define URL @"https://api.deutschebahn.com/fasta/v1/facilities/" // Neue API



@implementation ADAMCom
ADAMerci *merci;

///Gibt ein ADAMerci-Objekt zurück
- (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error
{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *token ; //GET THE TOKEN FROM THE KEYCHAIN
    token = APIKEY;
    
    NSString *authValue = [NSString stringWithFormat:@"Bearer %@",token];
    
//    //Configure your session with common header fields like authorization etc
//    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    sessionConfiguration.HTTPAdditionalHeaders = @{@"Authorization": authValue};
    
    
    NSError __block *err = NULL;
    NSData __block *data;
    BOOL __block reqProcessed = false;
    NSURLResponse __block *resp;
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable _data, NSURLResponse * _Nullable _response, NSError * _Nullable _error) {
        resp = _response;
        err = _error;
        data = _data;
        reqProcessed = true;
    }] resume];
    
    while (!reqProcessed) {
        [NSThread sleepForTimeInterval:0];
    }
    
    *response = resp;
    *error = err;
    return data;
}

-(ADAMerci*)dictionary_fromADAM
{
    NSURL *url=[NSURL URLWithString:URL];
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *mReq;
    mReq = [theRequest mutableCopy];
    NSString *bearer;
    bearer = @"";
    bearer = [bearer stringByAppendingString:(@"Bearer ")];
    bearer = [bearer stringByAppendingString:APIKEY];
    [mReq addValue:bearer forHTTPHeaderField:@"Authorization"];
    theRequest = [mReq copy];
    
    NSLog(@"%@",theRequest.allHTTPHeaderFields);
    
    NSError *err;
    NSURLResponse *resp;
    //NSData *data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&resp error:&err];
    NSData *urlData = [self sendSynchronousRequest:theRequest returningResponse:&resp error:&err];
    
    //DEPRECATED
    //NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString* datafromstring = [NSString stringWithUTF8String:[urlData bytes]];
//    NSLog(@"%@",datafromstring);
    
    
    NSMutableDictionary *dicti;
    dicti = [self dicfromdata:urlData];
    if (err)
    {
        NSLog(@"FEHLER %@",err.description);
    }
    
    
    NSMutableArray *equip = [dicti valueForKeyPath:@"equipmentnumber"];
    NSMutableArray *type = [dicti valueForKeyPath:@"type"];
    NSMutableArray *description = [dicti valueForKeyPath:(@"description")];
    NSMutableArray *geocoordX = [dicti valueForKeyPath:(@"geocoordX")];
    NSMutableArray *geocoordY = [dicti valueForKeyPath:(@"geocoordY")];
    NSMutableArray *state = [dicti valueForKeyPath:(@"state")];
    NSMutableArray *stationnumber = [dicti valueForKeyPath:(@"stationnumber")];
    if ([datafromstring containsString:(@"The server is temporarily")])
    {
        equip = [[NSMutableArray alloc] initWithObjects:(@"SHOWERROR") , nil];
        datafromstring = nil;
        
    }
    description = [[description arrayByReplacingNullsWithBlanks]mutableCopy];
    
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
    dicti = nil;
    urlData = nil;
    datafromstring = nil;
    err = nil;
    
    
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
