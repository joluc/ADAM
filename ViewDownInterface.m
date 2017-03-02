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
#import "Reachability.h"

//ist eigentlich alles selbsterklärend.
@implementation ViewDownInterface
NosFrame *framer;
UILabel *bigg;
UIImageView *imageview;
UIActivityIndicatorView *loadingimage;

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
    [imageview removeFromSuperview];
    [loadingimage removeFromSuperview];
    self.hidden = YES;
    framer = nil;
    
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
//    NSLog(@"%@",ID);
    
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
    
    imageview = [[UIImageView alloc]initWithFrame:self.frame];
    [self.mapviewadam addSubview:imageview];
    
    
    
    bigg = [[UILabel alloc]initWithFrame:self.frame];
    [bigg setFont:[UIFont boldSystemFontOfSize:self.frame.size.height/4]];
    bigg.textAlignment = NSTextAlignmentCenter;
    if ([nummerbahnnow valueForKey:ID])
    {
        bigg.text = [nummerbahnnow valueForKey:ID];
    }
    bigg.numberOfLines = 2;
    bigg.alpha = 0.8;
    
    bigg.backgroundColor = [UIColor whiteColor];
    [self.mapviewadam addSubview:bigg];
    
//    NSLog(@"%@",nameofstation_);
}
-(void)setimageurl:(NSString *)url
{
    
            NSLog(@"The internet is working via WIFI.");
            loadingimage = [[UIActivityIndicatorView alloc]initWithFrame:self.frame];
            loadingimage.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            loadingimage.backgroundColor = [UIColor whiteColor];
            [self.mapviewadam addSubview:loadingimage];
            [loadingimage startAnimating];
            [self loadImage:[NSURL URLWithString:url]];
}
- (void)loadImage:(NSURL *)imageURL
{
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(requestRemoteImage:)
                                        object:imageURL];
    [queue addOperation:operation];
}

- (void)requestRemoteImage:(NSURL *)imageURL
{
    NSLog(@"%@",imageURL.absoluteString);
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    [self performSelectorOnMainThread:@selector(placeImageInUI:) withObject:image waitUntilDone:NO];
    
}

- (void)placeImageInUI:(UIImage *)image
{
    if (![self image:[UIImage imageNamed:(@"streetview-1.jpeg")] isEqualTo:image])
    {
    [imageview setImage:image];
    imageview.contentMode = UIViewContentModeScaleToFill;
        [loadingimage stopAnimating];
        [loadingimage removeFromSuperview];
        loadingimage = nil;
    }
    else
    {
        printf("\n Image is same.");
        imageview.image = nil;
        imageview = nil;
        [loadingimage stopAnimating];
        [loadingimage removeFromSuperview];
        loadingimage = nil;
    }
}
- (BOOL)image:(UIImage *)image1 isEqualTo:(UIImage *)image2
{
    NSData *data1 = UIImagePNGRepresentation(image1);
    NSData *data2 = UIImagePNGRepresentation(image2);
    
    return [data1 isEqual:data2];
}
-(NSMutableDictionary*)dicfromdata:(NSData*)responseData
{
    
    NSError* error;
    NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
//    NSLog(@"%@",json.description);
    
    return json;
}

@end
