//
//  MyCollectionViewCell.m
//  BK42iOSManager
//
//  Created by chong feng on 15/12/3.
//  Copyright © 2015年 chong feng. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

@synthesize button;
@synthesize upcmd;
@synthesize downcmd;
@synthesize cellType;
@synthesize stateBack;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        cellType = TYPEBUTTON;
        stateBack = NO;
    }
    return self;
}
@end
