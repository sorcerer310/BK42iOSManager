//
//  ViewController.h
//  BK42iOSManager
//
//  Created by chong feng on 15/12/3.
//  Copyright © 2015年 chong feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewCell.h"
#import "NetHttpUtils.h"
#import "NYSegmentedControl.h"
#import "MyCollectionView.h"
#import "MJRefresh.h"

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,NetHttpUtilsDelegate>
@property (nonatomic,strong)NSMutableArray *dataMArr;                          //CollectionViewCell数据源
@property (nonatomic,weak) IBOutlet MyCollectionView *myCollectionView;        //CollectionView对象

@property (nonatomic,weak) IBOutlet UINavigationBar *navigationBar;            //导航条
@property (nonatomic,weak) IBOutlet NYSegmentedControl *segmentControl;        //选项卡对象

@property (nonatomic,strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;//左滑动手势
@property (nonatomic,strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;//右滑动手势


@end

