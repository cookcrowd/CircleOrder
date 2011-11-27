//
//  CircleViewItem.m
//  CircleOrder
//
//  Created by Mauricio Hanika on 26.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CircleViewItem.h"

@implementation CircleViewItem

@synthesize parentView = _parentView;

- (IBAction) onRemoveButtonClick:(id)sender {
    [[self parentView] removeSubView:self];
}

- (id)initWithParentView:(ViewController*)parentView {
    self = [super init];
    if(self) {
        [self setParentView:parentView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
