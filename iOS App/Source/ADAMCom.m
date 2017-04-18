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
<<<<<<< Updated upstream
#import <SCLAlertView-Objective-C/SCLAlertView.h>

//#define URL @"https://adam.noncd.db.de/api/v1.0/facilities" //Hier ist die alte API der Bahn
#define APIKEY @"CENSORED"
#define URL @"https://api.deutschebahn.com/fasta/v1/facilities/" // Neue API


=======
#import "ViewController.h"
#import <MapKit/MapKit.h>


#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "NSUserDefaults+RMSaveCustomObject.h"
#import "NSArray+CostumKVOOperators.h"



#define OLD_URL @"https://adam.noncd.db.de/api/v1.0/facilities" //Hier ist die API der Bahn
#define GetMissingStationNameURL @"https://api.deutschebahn.com/fasta/v1/stations/"
#define APIKEY @"CENSORED"
#define FaStaKEY @"Bearer CENSORED"
#define StationsBaseBearerAuthentikation @"Bearer CENSORED" // Schema : "Bearer DEINSCHLÜSSEL" -> Dieser kann auf dem OpenData-Portal erhalten werden :)
#define ReisezentrenAPI @"Bearer CENSORED"


#define URL @"https://api.deutschebahn.com/fasta/v1/facilities/" // Neue API

#define StationsBase @"https://api.deutschebahn.com/stada/v2/stations/" // Stations-URL ( v2 )
#define StationNameToInformationenURL @"https://api.deutschebahn.com/stada/v2/stations"

>>>>>>> Stashed changes

@implementation ADAMCom

ADAMerci *merci;

<<<<<<< Updated upstream
///Gibt ein ADAMerci-Objekt zurück
=======

///Gibt ein ADAMerci-Objekt zurück
-(void)setup
{
    _parent_viewcontroller.com = (id)self;
    
}
>>>>>>> Stashed changes
- (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error
{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
<<<<<<< Updated upstream
    NSString *token ; //GET THE TOKEN FROM THE KEYCHAIN
    token = APIKEY;
    
    NSString *authValue = [NSString stringWithFormat:@"Bearer %@",token];
=======
    
>>>>>>> Stashed changes
    
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
<<<<<<< Updated upstream

=======
-(void)save_as_latest:(ADAMerci*)merci
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults rm_setCustomObject:merci forKey:@"latest"];
    
}
-(ADAMerci*)loadLatest
{
    ADAMerci *merci;
    merci = [[NSUserDefaults standardUserDefaults] rm_customObjectForKey:(@"latest")];
    return merci;
}

//?searchstring=Stuttgart%20Feuersee

-(NSString*)getStationNameforStationID:(NSString*)equip
{
    NSString *stationName;
    
    NSString *getstationNameURL = GetMissingStationNameURL;
    getstationNameURL = [getstationNameURL stringByAppendingString:equip];
    getstationNameURL = [getstationNameURL stringByReplacingOccurrencesOfString:(@"Aufzug bei Station: ") withString:(@"")];
    getstationNameURL = [self parseStringtoDBStandard:getstationNameURL];
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:getstationNameURL]];
    NSMutableURLRequest *mReq;
    mReq = [theRequest mutableCopy];
    [mReq addValue:FaStaKEY forHTTPHeaderField:@"Authorization"];
    NSMutableDictionary *stationnamefail;
    stationnamefail = [[NSMutableDictionary alloc]init];
    NSError *err;
    NSURLResponse *resp;
    NSData *urlData = [self sendSynchronousRequest:mReq returningResponse:&resp error:&err]; // FaSTa
    if (err)
    {
        NSLog(@"ERROR: %@",err.description);
    }
    if (!err)
    {
        NSString* datafromstring = [NSString stringWithUTF8String:[urlData bytes]];
        NSLog(@"ANSWER: %@",datafromstring);
        
        if (resp) {
            NSMutableDictionary *dicti;
            dicti = [self dicfromdata:urlData];  // CREATING DICTI
            
            stationName = [dicti objectForKey:(@"name")];
            if (stationName)
            {
                return stationName;
            }
        }
    }
    
    return nil;
}
-(NSMutableDictionary*)getStationInformationwithName:(NSString*)stationName
{
    if (self.loadLocal)
    {
        return nil;
    }
    
    NSLog(@"STATION NAME INFORMATION LOADING");
    
    // STATION API
    NSError *err;
    NSError *errdic;
    NSURLResponse *resp;
    NSString *stringwithURL;
    stringwithURL = StationNameToInformationenURL;
    stringwithURL = [stringwithURL stringByAppendingString:(@"?searchstring=")];
    stringwithURL = [stringwithURL stringByAppendingString:stationName];
    
    stringwithURL = [self parseStringtoDBStandard:stringwithURL];
    NSLog(@"URL GENERATED: %@",stringwithURL);
    
    
    NSURL *url=[NSURL URLWithString:stringwithURL];
    
    NSLog(@"%@",url.absoluteString);
    
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *mReq;
    mReq = [theRequest mutableCopy];
    [mReq addValue:StationsBaseBearerAuthentikation forHTTPHeaderField:@"Authorization"];
    NSMutableDictionary *stationnamefail;
    stationnamefail = [[NSMutableDictionary alloc]init];
    
    NSData *urlData = [self sendSynchronousRequest:mReq returningResponse:&resp error:&err]; // FaSTa
    if (err)
    {
        NSLog(@"ERR %@",err.localizedDescription);
    }
    if (errdic)
    {
        NSLog(@"ERRDIC %@",errdic.localizedDescription);
    }
    if (!err)
    {
        if (!errdic)
        {
            NSString* datafromstring = [NSString stringWithUTF8String:[urlData bytes]];
            NSMutableDictionary *dicti;
            dicti = [self dicfromdata:urlData];
            
            NSLog(@"Looks like it worked: NAME : %@",datafromstring);
            
            
            // NSLog(@"Values: %@",dicti.allValues);
            
            NSString *StationName = [dicti valueForKeyPath:(@"result.name")];
            NSMutableDictionary *StationAddress = [dicti valueForKeyPath:(@"result.mailingAddress")];
            
            // EXAMPLE:
            //            {
            //                "offset": 0,
            //                "limit": 100,
            //                "total": 1,
            //                "result": [
            //                           {
            //                               "number": 144,
            //                               "name": "Andernach",
            //                               "mailingAddress": {
            //                                   "city": "Andernach",
            //                                   "zipcode": "56626",
            //                                   "street": "Kurfürstendamm 1"
            //                               },
            //                               "category": 3,
            //                               "hasParking": true,
            //                               "hasBicycleParking": true,
            //                               "hasLocalPublicTransport": true,
            //                               "hasPublicFacilities": false,
            //                               "hasLockerSystem": false,
            //                               "hasTaxiRank": true,
            //                               "hasTravelNecessities": true,
            //                               "hasSteplessAccess": "yes",
            //                               "hasMobilityService": "Nur nach Voranmeldung unter 01806 512 512",
            //                               "federalState": "Rheinland-Pfalz",
            //                               "regionalbereich": {
            //                                   "number": 5,
            //                                   "name": "RB Mitte",
            //                                   "shortName": "RB M"
            //                               },
            //                               "aufgabentraeger": {
            //                                   "shortName": "Zweckverband Schienenpersonennahverkehr Rheinland-Pfalz Nord",
            //                                   "name": "ZVRP Nord"
            //                               },
            //                               "timeTableOffice": {
            //                                   "email": "DBS.Fahrplan.RhldPfalzSaarland@deutschebahn.com",
            //                                   "name": "Bahnhofsmanagement Koblenz"
            //                               },
            //                               "szentrale": {
            //                                   "number": 24,
            //                                   "publicPhoneNumber": "06131/151055",
            //                                   "name": "Mainz Hbf"
            //                               },
            //                               "stationManagement": {
            //                                   "number": 181,
            //                                   "name": "Koblenz"
            //                               },
            //                               "evaNumbers": [
            //                                              {
            //                                                  "number": 8000331,
            //                                                  "geographicCoordinates": {
            //                                                      "type": "Point",
            //                                                      "coordinates": [
            //                                                                      7.404839,
            //                                                                      50.434542
            //                                                                      ]
            //                                                  },
            //                                                  "isMain": true
            //                                              }
            //                                              ],
            //                               "ril100Identifiers": [
            //                                                     {
            //                                                         "rilIdentifier": "KAND",
            //                                                         "isMain": true,
            //                                                         "hasSteamPermission": true,
            //                                                         "geographicCoordinates": {
            //                                                             "type": "Point",
            //                                                             "coordinates": [
            //                                                                             7.404382737,
            //                                                                             50.434696276
            //                                                                             ]
            //                                                         }
            //                                                     }
            //                                                     ]
            //                           }
            //                           ]
            //            }
            
            if ([dicti objectForKey:(@"error")])
            {
                return nil;
            }
            if ([dicti objectForKey:(@"errNo")])
            {
                return nil;
            }

            NSMutableDictionary *openingtimes;
            BOOL hasParking = [dicti valueForKeyPath:(@"result.hasParking.@firstObject")];
            BOOL hasBicycleParking = [dicti valueForKeyPath:(@"result.hasBicycleParking.@firstObject")];
            BOOL hasLocalPublicTransport = [dicti valueForKeyPath:(@"result.hasLocalPublicTransport.@firstObject")];
            BOOL hasPublicFacilities = [dicti valueForKeyPath:(@"result.hasPublicFacilities.@firstObject")];
            BOOL hasLockerSystem = [dicti valueForKeyPath:(@"result.hasLockerSystem.@firstObject")];
            BOOL hasTravelNecessities = [dicti valueForKeyPath:(@"result.hasTravelNecessities.@firstObject")];
            BOOL hasSteplessAccess = [dicti valueForKeyPath:(@"result.hasSteplessAccess.@firstObject")];
            NSMutableDictionary *geoCoords = [dicti valueForKeyPath:(@"result.evaNumbers.geographicCoordinates")];
            NSLog(@"%@",geoCoords);
            
            NSMutableDictionary *informationstation;
            informationstation = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  StationName, @"stationname",
                                  StationAddress, @"adresse",nil];
            
            
            if ([dicti valueForKeyPath:(@"result.szentrale")])
            {
                printf("\n Szentrale geladen");
                NSMutableDictionary *szentrale = [dicti valueForKeyPath:(@"result.szentrale")];
                [informationstation setObject:szentrale forKey:(@"szentrale")];
            }
            
            [informationstation setObject:[NSNumber numberWithBool:hasParking] forKey:(@"hasParking")];
            [informationstation setObject:[NSNumber numberWithBool:hasBicycleParking] forKey:(@"hasBicycleParking")];
            [informationstation setObject:[NSNumber numberWithBool:hasLocalPublicTransport] forKey:(@"hasLocalPublicTransport")];
            [informationstation setObject:[NSNumber numberWithBool:hasPublicFacilities] forKey:(@"hasPublicFacilities")];
            [informationstation setObject:[NSNumber numberWithBool:hasLockerSystem] forKey:(@"hasLockerSystem")];
            [informationstation setObject:[NSNumber numberWithBool:hasTravelNecessities] forKey:(@"hasTravelNecessities")];
            [informationstation setObject:[NSNumber numberWithBool:hasSteplessAccess] forKey:(@"hasSteplessAccess")];
            [informationstation setObject:geoCoords forKey:(@"geoCoords")];
            
            
            
            return informationstation;
            
        }
        return nil;
    }
    
    return nil;
    
}

-(NSMutableDictionary*)getStationInformation:(NSString*)stationID // UNNÜTZ, DA DIE STATIONIDs WELCHE BEI DEN AUFZÜGEN ANGEGEBEN WERDEN KEINE EVA-NUMMERN SIND
{
    if (self.loadLocal)
    {
        NSMutableDictionary *stationnamefail;
        stationnamefail = [[NSMutableDictionary alloc] initWithObjectsAndKeys:(@"Fail"),(@"stationname"), nil];
        return stationnamefail;
    }
    NSLog(@"STATION INFORMATION LOADING");
    
    // STATION API
    NSError *err;
    NSError *errdic;
    NSURLResponse *resp;
    NSString *stringwithURL;
    stringwithURL = StationsBase;
    stringwithURL = [stringwithURL stringByAppendingString:stationID];
    
    stringwithURL = [self parseStringtoDBStandard:stringwithURL];
    printf("\n URL PARSED: %s",stringwithURL.UTF8String);
    
    
    NSURL *url=[NSURL URLWithString:stringwithURL];
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *mReq;
    mReq = [theRequest mutableCopy];
    [mReq addValue:StationsBaseBearerAuthentikation forHTTPHeaderField:@"Authorization"];
    NSMutableDictionary *stationnamefail;
    stationnamefail = [[NSMutableDictionary alloc] initWithObjectsAndKeys:(@"Fail"),(@"stationname"), nil];
    
    NSData *urlData = [self sendSynchronousRequest:mReq returningResponse:&resp error:&err]; // FaSTa
    if (err)
    {
        NSLog(@"ERR %@",err.localizedDescription);
    }
    if (errdic)
    {
        NSLog(@"ERRDIC %@",errdic.localizedDescription);
    }
    if (!err)
    {
        if (!errdic)
        {
    NSString* datafromstring = [NSString stringWithUTF8String:[urlData bytes]];
    NSMutableDictionary *dicti;
    dicti = [self dicfromdata:urlData];
    
    NSLog(@"Looks like it worked: %@",datafromstring);
            
    // NSLog(@"Values: %@",dicti.allValues);
    
    NSString *StationName = [dicti valueForKeyPath:(@"result.name")];
    
    NSMutableDictionary *StationAddress = [dicti valueForKeyPath:(@"result.mailingAddress")];
            

    
    NSMutableDictionary *informationstation;
    informationstation = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                        StationName, @"stationname",
                        StationAddress, @"adresse",nil];
            
    return informationstation;
            
        }
        return stationnamefail;
    }
    
    return stationnamefail;
    
}
>>>>>>> Stashed changes
-(ADAMerci*)dictionary_fromADAM
{
    if (_loadLocal)
    {
        NSMutableDictionary *dicti;
        NSURL *imgPath = [[NSBundle mainBundle] URLForResource:@"fastabackup" withExtension:@"json"];
        NSString*stringPath = [imgPath absoluteString]; //this is correct
        //you can again use it in NSURL eg if you have async loading images and your mechanism
        //uses only url like mine (but sometimes i need local files to load)
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringPath]];
        dicti = [self dicfromdata:data];
        NSMutableArray *equip = [dicti valueForKeyPath:@"equipmentnumber"];
        NSMutableArray *type = [dicti valueForKeyPath:@"type"];
        NSMutableArray *description = [dicti valueForKeyPath:(@"description")];
        NSMutableArray *geocoordX = [dicti valueForKeyPath:(@"geocoordX")];
        NSMutableArray *geocoordY = [dicti valueForKeyPath:(@"geocoordY")];
        NSMutableArray *state = [dicti valueForKeyPath:(@"state")];
        NSMutableArray *stationnumber = [dicti valueForKeyPath:(@"stationnumber")];
        
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
        
        
        
        //    7.590019933
        //    50.358767133
        //    CENSORED KEY
        //    https://maps.googleapis.com/maps/api/streetview?size=600x300&location=46.414382,10.013988&heading=151.78&pitch=-0.76&key=
        return merci;

        
        
    }
    if (!_old_api)
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
<<<<<<< Updated upstream
    NSData *urlData = [self sendSynchronousRequest:theRequest returningResponse:&resp error:&err];
=======
    NSData *urlData = [self sendSynchronousRequest:theRequest returningResponse:&resp error:&err]; // FaSTa
        
        
>>>>>>> Stashed changes
    
    //DEPRECATED
    //NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString* datafromstring = [NSString stringWithUTF8String:[urlData bytes]];
//    NSLog(@"%@",datafromstring);
    
    
    NSMutableDictionary *dicti;
    dicti = [self dicfromdata:urlData];
<<<<<<< Updated upstream
=======
        
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    
    NSLog(@"%@",datafromstring);
        
        
>>>>>>> Stashed changes
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
    
    
<<<<<<< Updated upstream
=======
//    7.590019933
//    50.358767133
//    CENSORED KEY
//    https://maps.googleapis.com/maps/api/streetview?size=600x300&location=46.414382,10.013988&heading=151.78&pitch=-0.76&key=
>>>>>>> Stashed changes
    return merci;
    }
    if (_old_api)
    {
        NSURL *url=[NSURL URLWithString:URL];
        
        NSURLRequest *theRequest = [NSURLRequest requestWithURL:url];
        
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
        
        
        //    7.590019933
        //    50.358767133
        //    CENSORED KEY
        //    https://maps.googleapis.com/maps/api/streetview?size=600x300&location=46.414382,10.013988&heading=151.78&pitch=-0.76&key=
        
        
        // SAVE AS LATEST
        
        [self save_as_latest:merci];
        return merci;
    }
    return nil;
    
}
-(NSString*)parseStringtoDBStandard:(NSString*)inputString
{
    NSString *outputstring;
    
    
//    ä => %C3%A4
//    ö => %C3%B6
//    ü => %C3%BC
//    Ä => %C3%84
//    Ö => %C3%96
//    Ü => %C3%9C
//    ß => %C3%9F
    
    outputstring = inputString;
    outputstring = [outputstring stringByReplacingOccurrencesOfString:(@"ä") withString:(@"%C3%A4")];
    outputstring = [outputstring stringByReplacingOccurrencesOfString:(@"ö") withString:(@"%C3%B6")];
    outputstring = [outputstring stringByReplacingOccurrencesOfString:(@"ü") withString:(@"%C3%BC")];
    outputstring = [outputstring stringByReplacingOccurrencesOfString:(@"Ä") withString:(@"%C3%84")];
    outputstring = [outputstring stringByReplacingOccurrencesOfString:(@"Ö") withString:(@"%C3%96")];
    outputstring = [outputstring stringByReplacingOccurrencesOfString:(@"Ü") withString:(@"%C3%9C")];
    outputstring = [outputstring stringByReplacingOccurrencesOfString:(@"ß") withString:(@"%C3%9F")];
    outputstring = [outputstring stringByReplacingOccurrencesOfString:(@" ") withString:(@"%20")];
    
    return outputstring;
}
-(NSMutableDictionary*)dicfromdata:(NSData*)responseData
{
    
    NSError* error;
    NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
<<<<<<< Updated upstream
=======
    if (error)
    {
        NSLog(@"Something went wrong when parsing: Error: %@",error.localizedDescription);
    }
>>>>>>> Stashed changes
//    NSLog(@"%@",json.description); // Encoding zu JSON Log
    return json;
}
@end
