//
//  ViewController.m
//  CircleOrder
//
//  Created by Mauricio Hanika on 26.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <math.h>
#import "ViewController.h"
#import "CircleViewItem.h"

@implementation ViewController

@synthesize addButton = _addButton;
@synthesize radiusSlider = _radiusSlider;

# pragma mark - Action handlers

- (void) removeSubView: (id)subView {
    subView = (CircleViewItem*) subView;
    
    [UIView animateWithDuration:0.2 animations:^{
        [subView setAlpha:0];
    } completion:^(BOOL finished){
        [uiViews removeObjectIdenticalTo:(CircleViewItem*)subView];
        [subView removeFromSuperview];
        [self reorderSubViews];
    }];
    
    NSLog(@"Items left in array: %d", [uiViews count]);
}

- (IBAction) onAddButtonClick: (id)sender {
    NSLog(@"Add button clicked");
    
    NSArray *loadedView = [[NSBundle mainBundle] loadNibNamed:@"CircleViewItem" owner:self options:nil];
    
    CircleViewItem *subView = (CircleViewItem*) [loadedView objectAtIndex:0];
    
    // Place new items anywhere
    subView.center = CGPointMake(200, 200);
    
    // Add a link to the parent view, in order to
    // be able to remove the subView at a later time.
    // Because the subview contains the remove button,
    // we need this link to call removeSubView on this
    // UIViewController.
    [subView setParentView:self];
    
    if(! [uiViews containsObject:subView] && [uiViews count] < 5) {
        // In order to avoid seeing new items being animated
        // from its initial position to the circle, hide them
        // and only after the item circle has been reordered
        // (see reorderSubViews), fade all new items in.
        [subView setAlpha:0];
        
        [uiViews addObject:subView];
        [self.view addSubview:subView];
        
        [self reorderSubViews];
    }
}

- (IBAction) onRadiusSliderValueChange: (id)sender {
    [self reorderSubViews];
}

- (void) reorderSubViews {
    [UIView animateWithDuration:0.5 animations:^{
        // Reorder all uiView items. The radius of the circle is based
        // on the amount of items in the array.
        float radius = (100 + (50 * ([uiViews count] / 4 ))) * [self.radiusSlider value];
        CGPoint circleCenter = [self.view center];
        for (int i = 1, j = [uiViews count]; i <= j; i++) {
            UIView *currView = [uiViews objectAtIndex:i - 1];
            
            // We need to calculate the angle for the current item in the circle.
            // A circle has a radius of 2*M_PI and we rotate it 90 deg (M_PI_2) anticlockwise,
            // so the first item in an new array is positioned at 90 deg.
            // If there is more than one item in the array, we split the circle
            // in j parts (the amount of items) and evety item is rotated +1 of
            // those parts.
            float currAngleRad = ((float)i / (float)j) * (2 * M_PI) - M_PI_2;
            
            // Get the dx and dy values for the current items angle.
            float dx = radius * cos(currAngleRad);
            float dy = radius * sin(currAngleRad);
            
            NSLog(@"dx: %f, dy: %f, i: %d, j: %d, i/j: %f, currAngle: %f", dx, dy, i, j, ((float)i/(float)j), currAngleRad * (180 / M_PI));
            
            // Add dx and dy to the center of the circle, thus placing
            // the current item on the outer circle on its calculated position.
            float newX = circleCenter.x + dx;
            float newY = circleCenter.y + dy;
            
            // Weird.
            currView.center = CGPointMake(newX, newY);
        }
    } completion:^(BOOL finished) {
        // New items are made transparent. After reordering the existing items,
        // we need to fade in the new item.
        [UIView animateWithDuration:0.4 animations:^{
            for(int i = 0, j = [uiViews count]; i < j; i++) {
                UIView *currView = [uiViews objectAtIndex:i];
                
                [currView setAlpha:1];
            }
        }];
    }];
}

# pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    uiViews = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.addButton = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
