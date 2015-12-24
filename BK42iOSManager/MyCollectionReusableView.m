//
//  MyCollectionReusableView.m
//  BK42iOSManager
//
//  Created by chong feng on 15/12/24.
//  Copyright © 2015年 chong feng. All rights reserved.
//

#import "MyCollectionReusableView.h"

@implementation MyCollectionReusableView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        //初始化代码
        NSLog(@"============");
//        [self dumpIsReadyInit];
    }
    return self;
}

//-(void)dumpIsReadyInit{
//    self.dumpIsReady.layer.backgroundColor = [UIColor redColor].CGColor;
//    self.dumpIsReady.layer.cornerRadius = 20;
//}

@end
