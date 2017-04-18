//
//  JFMapView.m
//  ADAM - Ausbau der Digitalisierung im Anlagenmanagement
//
//  Created by Jonathan Lucas Fritz on 24.02.17.
//  Copyright © 2017 NOSCIO. All rights reserved.
//

#import "JFMapView.h"
#import "GridTileOverlay.h"

<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
@implementation JFMapView

-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    UIScrollView * scroll = [[[[self subviews] objectAtIndex:0] subviews] objectAtIndex:0];
    
    if (scroll.zoomScale > 0.05) {
        [scroll setZoomScale:0.09 animated:NO];
        printf("\n BITCH ");
    }
    
}
- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context
{
    printf("\n AD ");
<<<<<<< Updated upstream
    
=======
>>>>>>> Stashed changes
    self.gridOverlay = [[GridTileOverlay alloc] init];
    self.gridOverlay.canReplaceMapContent=NO;
    [self addOverlay:self.gridOverlay level:MKOverlayLevelAboveLabels];
}
@end
