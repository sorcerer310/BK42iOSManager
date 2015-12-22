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

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic)NSMutableArray *dataMArr;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end

