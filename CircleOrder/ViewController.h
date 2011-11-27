//
//  ViewController.h
//  CircleOrder
//
//  Created by Mauricio Hanika on 26.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSMutableArray *uiViews;
}

- (void) removeSubView: (id)subView;
- (void) reorderSubViews;
- (IBAction) onAddButtonClick: (id)sender;
- (IBAction) onRadiusSliderValueChange: (id)sender;

@property(nonatomic, strong) IBOutlet UIButton *addButton;
@property(nonatomic, strong) IBOutlet UISlider *radiusSlider;

@end
