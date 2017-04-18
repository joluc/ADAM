//
//  InfoViewTable.m
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 14.04.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import "InfoViewTable.h"

NSMutableArray *infoarray;
NSMutableDictionary *dici;

CGRect backupFrame;
int isbig;
BOOL openingtimesloaded;


@implementation InfoViewTable

-(void)loadwithDictionary:(NSMutableDictionary*)dic
{
//    adresse =     (
//                   {
//                       city = "T\U00fcbingen";
//                       street = "Europaplatz 17";
//                       zipcode = 72072;
//                   }
//                   );
//    stationname =     (
//                       "T\U00fcbingen Hbf"
//                       );
    
    dici = [dic mutableCopy];
    
    NSMutableArray *name_bahnhof_array;
    NSString *name_bahnhof;
    name_bahnhof_array = [dic objectForKey:(@"stationname")];
    name_bahnhof = name_bahnhof_array.firstObject;
    NSLog(@"%@",dic.allKeys);
    
    
//    adresse,
//    hasParking,
//    hasTravelNecessities,
//    hasLockerSystem,
//    hasPublicFacilities,
//    hasLocalPublicTransport,
//    hasBicycleParking,
//    hasSteplessAccess,
//    evaNumber
//    stationname
    
    NSMutableArray *szentraleouter = [dic objectForKey:(@"szentrale")];
    NSMutableDictionary *szentrale = [dic objectForKey:(@"szentrale")];
    NSString *szentrale_call;
    if (szentrale)
    {
        szentrale = szentraleouter.firstObject;
        NSLog(@"Szentrale: %@",szentrale.description);
        szentrale_call = [szentrale objectForKey:(@"publicPhoneNumber")];
    }
    
    infoarray = [[NSMutableArray alloc]init];
    [infoarray addObject:name_bahnhof];
    [infoarray addObject:[self getValueforKey:(@"hasParking")]];
    [infoarray addObject:[self getValueforKey:(@"hasTravelNecessities")]];
    [infoarray addObject:[self getValueforKey:(@"hasLockerSystem")]];
    [infoarray addObject:[self getValueforKey:(@"hasPublicFacilities")]];
    [infoarray addObject:[self getValueforKey:(@"hasLocalPublicTransport")]];
    [infoarray addObject:[self getValueforKey:(@"hasBicycleParking")]];
    [infoarray addObject:[self getValueforKey:(@"hasSteplessAccess")]];
    if (szentrale_call)
    {
        [infoarray addObject:szentrale_call];
    }
    
    
     
    self.delegate = (id)self;
    self.dataSource = (id)self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // ARRAY CREATION
    printf("\n WORKING @ TABLEVIEW");
    backupFrame = self.frame;
    isbig = 0;
    self.backgroundColor = [UIColor clearColor];
    
    
    
    [self reloadData];
}
-(NSString*)getValueforKey:(NSString*)key
{
    if ([dici objectForKey:key])
    {
        return @"Vorhanden";
    }
    return @"Nicht vorhanden";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (openingtimesloaded)
    {
    return 2;    //count of section
    }
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (openingtimesloaded)
    {
    if (section == 0)
    {
    return infoarray.count-1;    //count number of row from counting array hear cataGorry is An Array
    }
    if (section == 1)
    {
        return 1;
    }
    return 0;
    }
    return infoarray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 70;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",(int)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
//    cell.textLabel.text = infoarray[indexPath.row];
    
    
    //    adresse,
    //    hasParking,
    //    hasTravelNecessities,
    //    hasLockerSystem,
    //    hasPublicFacilities,
    //    hasLocalPublicTransport,
    //    hasBicycleParking,
    //    hasSteplessAccess,
    //    evaNumber
    //    stationname
    if (indexPath.section == 0)
    {
    if (indexPath.row == 0)
    {
        cell.detailTextLabel.text = (@"Bahnhofsname");
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:12];
        cell.detailTextLabel.numberOfLines = 0;
        cell.textLabel.text = [infoarray objectAtIndex:indexPath.row];
        return cell;
    }
    if (indexPath.row == 1)
    {
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:cell.detailTextLabel.font.pointSize];
        cell.detailTextLabel.text = [infoarray objectAtIndex:indexPath.row];
        cell.textLabel.text = (@"Parkmöglichkeiten");
        cell.textLabel.alpha = 1.0;
        cell.detailTextLabel.alpha = 1.0;
    }
    if (indexPath.row == 2)
    {
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:cell.detailTextLabel.font.pointSize];
        cell.detailTextLabel.text = [infoarray objectAtIndex:indexPath.row];
        cell.textLabel.text = (@"Reiseunterstützung");
        cell.textLabel.alpha = 0.4;
        cell.detailTextLabel.alpha = 0.4;
    }
    if (indexPath.row == 3)
    {
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:cell.detailTextLabel.font.pointSize];
        cell.detailTextLabel.text = [infoarray objectAtIndex:indexPath.row];
        cell.textLabel.text = (@"Schließfächer");
        cell.textLabel.alpha = 0.4;
        cell.detailTextLabel.alpha = 0.4;
    }
    if (indexPath.row == 4)
    {
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:cell.detailTextLabel.font.pointSize];
        cell.detailTextLabel.text = [infoarray objectAtIndex:indexPath.row];
        cell.textLabel.text = (@"Postdienste");
        cell.textLabel.alpha = 0.4;
        cell.detailTextLabel.alpha = 0.4;
    }
    if (indexPath.row == 5)
    {
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:cell.detailTextLabel.font.pointSize];
        cell.detailTextLabel.text = [infoarray objectAtIndex:indexPath.row];
        cell.textLabel.text = (@"ÖPNV");
        cell.textLabel.alpha = 0.4;
        cell.detailTextLabel.alpha = 0.4;
    }
    if (indexPath.row == 6)
    {
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:cell.detailTextLabel.font.pointSize];
        cell.detailTextLabel.text = [infoarray objectAtIndex:indexPath.row];
        cell.textLabel.text = (@"Fahrradparkplätze");
        cell.textLabel.alpha = 0.4;
        cell.detailTextLabel.alpha = 0.4;
    }
    if (indexPath.row == 7)
    {
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:cell.detailTextLabel.font.pointSize];
        cell.detailTextLabel.text = [infoarray objectAtIndex:indexPath.row];
        cell.textLabel.text = (@"Stufenloser Zugang");
        cell.textLabel.alpha = 0.4;
        cell.detailTextLabel.alpha = 0.4;
    }
    if (indexPath.row == 8)
    {
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:cell.detailTextLabel.font.pointSize];
        cell.detailTextLabel.text = [infoarray objectAtIndex:indexPath.row];
        cell.textLabel.text = (@"3SZentrale anrufen");
        cell.textLabel.alpha = 0.4;
        cell.detailTextLabel.alpha = 0.4;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
        
    if (isbig == 0)
    {
        cell.textLabel.alpha = 0.4;
        cell.detailTextLabel.alpha = 0.4;
    }
    if (isbig == 1)
    {
        cell.textLabel.alpha = 1.0;
        cell.detailTextLabel.alpha = 1.0;
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    printf("\n LOADING TABLEVIEWCELL");
    
    
    return cell;
    }
    if (indexPath.section == 1)
    {
        cell.textLabel.text = (@"Reiseunterstützung");
        return cell;
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
    if (isbig == 0)
    {
    return @"Tippen, um zu erweitern";
    }
    if (isbig == 1)
    {
        return @"Nach unten ziehen zum verkleinern";
    }
    return @"Bahnhofinformationen";
    }
    if (section == 1)
    {
        return @"Öffnungszeiten";
    }
    return @"Bahnhofinformationen";
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    footer.backgroundColor = [UIColor clearColor];
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:footer.frame];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = @"Alle Angaben ohne Gewähr. Die Daten stammen von der Stada-API.";
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.numberOfLines = 0;
    [footer addSubview:lbl];
    
    return footer;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<=-10) {
        if (isbig == 1)
        {
        isbig = 2;
            
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationOptionTransitionCurlUp
                         animations:^{
                             self.frame = backupFrame;
                         }
                         completion:^(BOOL finished){
                             if (finished)
                             {
                             [self reloadData];
                             isbig = 0;
                             }
                         }];
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (isbig == 0)
    {
        isbig = 2;
        
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationOptionTransitionCurlUp
                         animations:^{
                             self.frame = self.parent_info_viewc.view.frame;
                         }
                         completion:^(BOOL finished){
                             if (finished)
                             {
                             [self reloadData];
                             isbig = 1;
                             }
                         }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 8)
    {
        NSString *phoneCallNum = [NSString stringWithFormat:@"tel://%@",[self cellForRowAtIndexPath:indexPath].textLabel.text ];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneCallNum]];
    }
}


@end
