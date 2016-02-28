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
@property (strong, nonatomic)NSMutableArray *dataMArr;                          //CollectionViewCell数据源
@property (weak, nonatomic) IBOutlet MyCollectionView *myCollectionView;        //CollectionView对象

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;            //导航条
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;        //选项卡对象
//@property (weak, nonatomic) IBOutlet UILabel *labelDumpIsReady;                 //敲鼓状态显示

@end

