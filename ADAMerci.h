//
//  ADAMerci.h
//  ADAM by Noscio
//
//  Created by Jonathan Lucas Fritz on 12.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADAMerci : NSObject
@property NSMutableArray *equip;
@property NSMutableArray *type;
@property NSMutableArray *description_;
@property NSMutableArray *geocoordX;
@property NSMutableArray *geocoordY;
@property NSMutableArray *state;
@property NSMutableArray *stationnumber;
@property NSMutableDictionary *stationnumberfornames;
/**
 *  @author         Jonathan Fritz
 *  @version        0.5
 *   ADAMerci wird aus ADAMCom gebildet und beinhaltet alle Informationen welche für die Anzeige des Status und das Lokalisieren der Aufzüge und Rolltreppen benötigt werden.
 *
 */

-(NSMutableDictionary*)dicforindex:(int)index;
-(NSMutableArray*)coords;
-(NSString*)statusforquipmentnumber:(NSString*)ID;
-(NSString*)typeforquipmentnumber:(NSString*)ID;
-(NSString*)desforquipmentnumber:(NSString*)ID;


@end
