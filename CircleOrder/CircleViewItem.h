//
//  CircleViewItem.h
//  CircleOrder
//
//  Created by Mauricio Hanika on 26.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface CircleViewItem : UIView

- (IBAction) onRemoveButtonClick:(id)sender;

@property(nonatomic, assign) ViewController *parentView;

@end
