//
//  SearchView.m
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 15.04.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import "SearchView.h"
#import "UIColor+Hex.h"
#import "ViewController.h"
#import "ADAM_MapView.h"
#import "MBProgressHUD.h"



@implementation SearchView
NSMutableArray *baseSearchArray;
NSMutableArray *filtered;
UISearchBar *searchBar;
NSMutableDictionary *info_forStationName;
NSMutableDictionary *otherkeys;
MKPlacemark *placemark;
UIView *doingthingpleaswait;
MBProgressHUD *HUD3;
UIButton *closeButton;
CGRect startFrame;




BOOL isSearching;


@synthesize tableView;

-(void)setup
{
    doingthingpleaswait = [[UIView alloc]initWithFrame:self.parent_search.view.frame];
    [self.parent_search.view addSubview:doingthingpleaswait];
    UIActivityIndicatorView *running = [[UIActivityIndicatorView alloc] initWithFrame:doingthingpleaswait.frame];
    running.contentMode = UIViewContentModeScaleAspectFit;
    [doingthingpleaswait addSubview:running];
    doingthingpleaswait.hidden = true;
    
    self.backgroundColor = [UIColor whiteColor];
//    "EVA_NR": 8000404,
//    "DS100": "KAW",
//    "NAME": "Aachen West",
//    "VERKEHR": "RV",
//    "LAENGE": 6.070715,
//    "BREITE": 50.78036,
//    "": ""
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"stationnamen" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSMutableDictionary *objectdata;
    objectdata = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    baseSearchArray = [objectdata valueForKeyPath:(@"NAME")];
    
    NSMutableArray *EVA = [objectdata valueForKey:@"EVA_NR"];
    NSMutableArray *LANG = [objectdata valueForKey:@"LAENGE"];
    NSMutableArray *BREITE = [objectdata valueForKey:@"BREITE"];
    
    info_forStationName = [[NSMutableDictionary alloc]init];
    int indexer;
    indexer = 0;
    bool undone = false;
    isSearching = false;
    
    for (NSString *string in baseSearchArray)
    {
        NSMutableDictionary *dicforonekey;
        dicforonekey = [[NSMutableDictionary alloc] init];
        [dicforonekey setObject:EVA[indexer] forKey:(@"EVA")];
        [dicforonekey setObject:LANG[indexer] forKey:(@"LANG")];
        [dicforonekey setObject:BREITE[indexer] forKey:(@"BREITE")];
        [info_forStationName setObject:dicforonekey forKey:string];
        indexer++;
        if ([string isEqualToString:(@"Zwotental")]) // FERTIG MIT ALLEM
        {
            undone = false;
            searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(self.frame.size.width/7, 0, self.frame.size.width-self.frame.size.width/7, self.frame.size.height/10)];
            searchBar.barStyle = UIBarMetricsCompact;
            searchBar.barTintColor = [UIColor whiteColor];
            searchBar.delegate = (id)self;
            
            closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/7, self.frame.size.height/10)];
            [closeButton addTarget:self action:@selector(closeSearchBar) forControlEvents:UIControlEventPrimaryActionTriggered];
            [closeButton setTitle:(@"X") forState:UIControlStateNormal];
            closeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [closeButton setBackgroundColor:[UIColor colorWithCSS:(@"#FE6500")]];
            
            [self addSubview:closeButton];
            
            [self addSubview:searchBar];
            
            tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.frame.size.height/10, self.frame.size.width, self.frame.size.height-self.frame.size.height/10) style:UITableViewStylePlain];
            tableView.delegate = (id)self;
            tableView.dataSource = (id)self;
            [self addSubview:tableView];
            
            filtered = [baseSearchArray copy];
            [tableView reloadData];
            [searchBar setReturnKeyType:UIReturnKeyDone];
            startFrame = tableView.frame;
            
            
        }
    }
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"Abbrechen"];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor colorWithCSS:(@"#FE6500")]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return filtered.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    
    cell.textLabel.text = filtered[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Ergebnisse";
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
-(void)resetSearch
{
    filtered = [baseSearchArray mutableCopy];
    [tableView reloadData];
}
-(void)search_results:(NSString*)string
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",string];
    filtered  = (NSMutableArray*)[baseSearchArray filteredArrayUsingPredicate:predicate];
    [tableView reloadData];
}
-(void)closeSearchBar
{
    [UIView animateWithDuration:0.8
                          delay:0.0
                        options: UIViewAnimationOptionTransitionCurlUp
                     animations:^{
                         self.alpha = 0.1;
                         [searchBar resignFirstResponder];
                     }
                     completion:^(BOOL finished){
                         self.hidden = YES;
                         self.alpha = 1.0;
                         
                         CGRect frame = CGRectMake(self.tableView.frame.origin.x,
                                                   self.tableView.frame.origin.y,
                                                   self.tableView.frame.size.width,
                                                   self.frame.size.height);
                         self.tableView.frame = startFrame;
                         
                     }];
    
}
- (void)keyboardDidShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.8
                          delay:0.0
                        options: UIViewAnimationOptionTransitionCurlUp
                     animations:^{
                         NSDictionary *userInfo = [notification userInfo];
                         CGSize size = [[userInfo objectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
                         CGRect frame = CGRectMake(self.tableView.frame.origin.x,
                                                   self.tableView.frame.origin.y,
                                                   self.tableView.frame.size.width,
                                                   self.tableView.frame.size.height - size.height);
                         self.tableView.frame = frame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (void)keyboardDidHide:(NSNotification*)notification
{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary *dictiforcell;
    dictiforcell = [info_forStationName objectForKey:cell.textLabel.text];
    NSLog(@"%@",dictiforcell.description);
    
    NSString *name_station = cell.textLabel.text;

    NSString *message_for_user;
    message_for_user = (@"Möchtest du zu der Station ");
    message_for_user = [message_for_user stringByAppendingString:name_station];
    message_for_user = [message_for_user stringByAppendingString:(@" mehr Informationen erhalten?")];
    
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:(@"Bestätigung erforderlich") message:message_for_user preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action_handler_one;
    action_handler_one = [UIAlertAction actionWithTitle:(@"Informationen laden") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [searchBar resignFirstResponder];
        [self resetSearch];
        
        float LAT = [[dictiforcell objectForKey:(@"BREITE")] floatValue];
        float LON = [[dictiforcell objectForKey:(@"LANG")] floatValue];
        CLLocationCoordinate2D coordinateforstation = CLLocationCoordinate2DMake(LAT,LON);
        placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(LAT, LON) addressDictionary:nil];
        MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = LAT;
        region.center.longitude = LON;
        region.span.longitudeDelta = 0.03f;
        region.span.latitudeDelta = 0.03f;
        self.parent_search.mapView.given_station_name = name_station;
        HUD3 = [MBProgressHUD showHUDAddedTo:self.parent_search.view animated:true];
        HUD3.detailsLabel.text = (@"Kombiniere Datensätze...");
        [self.parent_search.mapView.map setRegion:region animated:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            doingthingpleaswait.hidden = NO;
            doingthingpleaswait.backgroundColor = [UIColor blackColor];
            doingthingpleaswait.alpha = 0.4;
        });
        NSTimer *waitandselecttimer;
        waitandselecttimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(waitandselect) userInfo:nil repeats:NO];
        
        self.hidden = true;
        
    }];
    
    UIAlertAction *action_handler_cancel = [UIAlertAction actionWithTitle:(@"Abbrechen") style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
    
        
        printf("\n Abbrechen");
        
    }];
    
    
    //Aktionen hinzufügen.
    [alertController addAction:action_handler_one];
    [alertController addAction:action_handler_cancel];
    
    [self.parent_search presentViewController:alertController animated:true completion:^(){
        
        printf("\n Displaying ViewController");
        
    }];
    
}
-(void)waitandselect
{
    [HUD3 hideAnimated:YES];
    doingthingpleaswait.hidden = true;
    [self.parent_search.mapView.map addAnnotation:placemark];
    [self.parent_search.mapView.map selectAnnotation:placemark animated:false];
}
// SEARCHBAR
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (![searchText isEqualToString:(@"")])
    {
        isSearching = true;
        [self search_results:searchText];
    }
    if ([searchText isEqualToString:(@"")])
    {
        isSearching = false;
        [tableView reloadData];
    }
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.text = (@"");
    [self resetSearch];
    [searchBar setShowsCancelButton:NO animated:YES];
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionTransitionCurlUp
                     animations:^{
                         self.tableView.frame = startFrame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

@end
