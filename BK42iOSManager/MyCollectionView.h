//
//  MyCollectionView.h
//  BK42iOSManager
//
//  Created by chong feng on 15/12/24.
//  Copyright © 2015年 chong feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionView : UICollectionView
@property (nonatomic,strong) NSMutableArray * stateCells;                         //用来保存当前CollectionView中所有的state cell

@end
