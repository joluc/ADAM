//
//  ADAMerci.m
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//
#import "ADAMerci.h"
#import <MapKit/MapKit.h>


@implementation ADAMerci // Ganz wichtiges Teil

//@property NSMutableArray *equip;
//@property NSMutableArray *type;
//@property NSMutableArray *description_;
//@property NSMutableArray *geocoordX;
//@property NSMutableArray *geocoordY;
//@property NSMutableArray *state;
//@property NSMutableArray *stationnumber;

///Gibt ein Dictionarie zurück mit den Werten aus den Arrays welche auf dem jeweiligen Index liegen. Umständliche Lösung! Aber klappt!
-(NSMutableDictionary*)dicforindex:(int)index
{
    
    NSMutableDictionary *dictionaryforindex;
    
    dictionaryforindex = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                          [_equip objectAtIndex:index], @"equipmentnumber",
                          [_type objectAtIndex:index], @"type",
                          [_description_ objectAtIndex:index], @"description",
                          [_geocoordX objectAtIndex:index], @"geocoordX",
                          [_geocoordY objectAtIndex:index], @"geocoordY",
                          [_state objectAtIndex:index], @"state",
                          [_stationnumber objectAtIndex:index], @"stationnumber",nil];
    
    return dictionaryforindex;
}
-(NSMutableArray*)coords // Hier werden die einzelnen Koordinaten kombiniert und in CLLocationdinger umgewandelt
{
    
    int drei;
    drei = 0;
    
    NSMutableArray *geocoords;
    geocoords = [[NSMutableArray alloc]init];
    for (NSNumber *index in _geocoordX)
    {
        CLLocationCoordinate2D loc;
        NSString *variable = [NSString stringWithFormat:@"%@", [_geocoordX objectAtIndex:drei]];
        NSString *variable2 = [NSString stringWithFormat:@"%@", [_geocoordY objectAtIndex:drei]];
        
        loc.longitude = variable.floatValue;
        loc.latitude = variable2.floatValue;
        
//    for (NSNumber *geox in _geocoordX)
//    {
//        NSString *variable = [NSString stringWithFormat:@"%@", geox];
//        loc.longitude = variable.floatValue;
//        
//    }
//    for (NSNumber *geoy in _geocoordY)
//    {
//        NSString *variable = [NSString stringWithFormat:@"%@", geoy];
//        loc.latitude = variable.floatValue;
//    }
//        [geocoords addObject:[NSData dataWithBytes:&loc length:sizeof(loc)]];
        [geocoords addObject:[NSValue valueWithMKCoordinate:loc]];
        drei++;
    }
    
    return geocoords;
}
-(NSString*)statusforquipmentnumber:(NSString*)ID // Hier wird für die ID welche sich auch der annotation subtitle befindet ein Status des Aufzuges ausgegeben
{
//    NSLog(@"LOOKUP: %@",ID);
    
    long longlong;
    longlong = ID.longLongValue;
//    NSLog(@"%ld",longlong);
    NSNumber *number;
    number = [NSNumber numberWithLong:ID.longLongValue];
//    NSLog(@"%@",number);
    
    NSUInteger value = [_equip indexOfObject:number];
//    NSLog(@"is on Index: %d",value);
    
    NSString *state_;
    state_ = [_state objectAtIndex:value];
//    NSLog(@"ID: %@",ID);
//    NSLog(@"is marked as %@",state_);
    
    
    return state_;
}
-(NSString*)desforquipmentnumber:(NSString*)ID // Hier kann man eine Beschreibung ausgeben... Allerdings fehlt die leider relativ oft :(
{
    //    NSLog(@"LOOKUP: %@",ID);
    
    long longlong;
    longlong = ID.longLongValue;
    //    NSLog(@"%ld",longlong);
    NSNumber *number;
    number = [NSNumber numberWithLong:ID.longLongValue];
    //    NSLog(@"%@",number);
    
    NSUInteger value = [_equip indexOfObject:number];
    
    //    NSLog(@"is on Index: %d",value);
    if (value == NSNotFound)
    {
        return (@"Nicht gefunden");
        
    }
    
    NSString *state_;
    state_ = [_description_ objectAtIndex:value];
    
    //    NSLog(@"ID: %@",ID);
    //    NSLog(@"is marked as %@",state_);
    
    
    return state_;
}
-(NSString*)typeforquipmentnumber:(NSString*)ID // Und hiermit kann man erkennen, ob es eine Rolltreppe ist ( von denen es aktuell 2 gibt die eingetragen sind ) oder eine der hunderten Aufzüge 
{
    //    NSLog(@"LOOKUP: %@",ID);
    
    long longlong;
    longlong = ID.longLongValue;
    //    NSLog(@"%ld",longlong);
    NSNumber *number;
    number = [NSNumber numberWithLong:ID.longLongValue];
    //    NSLog(@"%@",number);
    
    NSUInteger value = [_equip indexOfObject:number];
    //    NSLog(@"is on Index: %d",value);
    
    NSString *state_;
    state_ = [_type objectAtIndex:value];
    //    NSLog(@"ID: %@",ID);
    //    NSLog(@"is marked as %@",state_);
    
    
    return state_;
}

@end