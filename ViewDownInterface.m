//
//  ViewDownInterface.m
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 14.08.16.
//  Copyright © 2016 NOSCIO. All rights reserved.
//

#import "ViewDownInterface.h"
#import "NosFrame.h"
#import "outrepasser.h"


@implementation ViewDownInterface
NosFrame *framer;
UILabel *bigg;

int actindex;

-(void)setup
{
    framer = [[NosFrame alloc]init];
    framer.main = self;
    
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    printf("\n HELLO ");
    NSString *message;
    
    UIAlertController *control;
    control = [UIAlertController alertControllerWithTitle:(@"Informationen") message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action;
    action = [UIAlertAction actionWithTitle:(@"Schließen") style:UIAlertActionStyleDefault handler:nil];
    [control addAction:action];
    [self.mapviewadam.viewc presentViewController:control animated:YES completion:nil];
    
    
}
-(void)sethiddennow
{
    [bigg removeFromSuperview];
    
    self.hidden = YES;
}
-(void)loadforID:(NSString *)ID
{
    self.hidden = NO;
//    https://adam.noncd.db.de/api/v1.0/stations/27
    
//    NSString *number;
//    number = [self typeforquipmentnumber:ID];
//    NSLog(@"%@",number);
    self.backgroundColor = [UIColor whiteColor];
    
    
//    if ([ID containsString:(@"Aufzug")])
//    {
//    clean = [ID stringByReplacingOccurrencesOfString:(@"Aufzug bei Station: ") withString:(@"")];
//    }
//    if ([ID containsString:(@"Rolltreppe")])
//    {
//        clean = [ID stringByReplacingOccurrencesOfString:(@"Rolltreppe bei Station: ") withString:(@"")];
//    }
//    
    NSLog(@"%@",ID);
    
    [self typeforquipmentnumber:ID];
    
}

-(void)typeforquipmentnumber:(NSString*)ID
{
    NSString *nameofstation_;
    nameofstation_ = (@"Name: ");
    
//    https://adam.noncd.db.de/api/v1.0/stations/27
//    NSString *urlstring;
//    urlstring = (@"https://adam.noncd.db.de/api/v1.0/stations/");
//    urlstring = [urlstring stringByAppendingString:ID];
//    
//    NSURL *url=[NSURL URLWithString:urlstring];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:url];
//    [request setHTTPMethod:@"GET"];
//    
//    NSError *error;
//    NSURLResponse *response;
//    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSMutableDictionary *dicti;
//    dicti = [self dicfromdata:urlData];
//    
//    NSString *nameders;
//    nameders = [dicti valueForKey:(@"name")];
    
//    nameofstation_ = [self.bonjour.stationnumberfornames valueForKey:ID];
//    NSLog(@"%@",self.bonjour.stationnumberfornames.description);
//    
    
    bigg = [[UILabel alloc]initWithFrame:self.frame];
    [bigg setFont:[UIFont systemFontOfSize:self.frame.size.height/3]];
    bigg.textAlignment = NSTextAlignmentCenter;
    bigg.text = [nummerbahnnow valueForKey:ID];
    
    
    
    bigg.backgroundColor = [UIColor whiteColor];
    [self.mapviewadam addSubview:bigg];
    NSLog(@"%@",nameofstation_);
}
-(NSMutableDictionary*)dicfromdata:(NSData*)responseData
{
    
    NSError* error;
    NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSLog(@"%@",json.description);
    
    return json;
}

@end
