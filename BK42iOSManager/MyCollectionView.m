//
//  MyCollectionView.m
//  BK42iOSManager
//
//  Created by chong feng on 15/12/24.
//  Copyright © 2015年 chong feng. All rights reserved.
//

#import "MyCollectionView.h"

@implementation MyCollectionView
@synthesize stateCells;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self!=nil){
        stateCells = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
