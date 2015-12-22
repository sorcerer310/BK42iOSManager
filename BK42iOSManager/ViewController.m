//
//  ViewController.m
//  BK42iOSManager
//
//  Created by chong feng on 15/12/3.
//  Copyright © 2015年 chong feng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize segmentControl;
NetHttpUtils *http;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置服务器路径
    http = [[NetHttpUtils alloc] initWithUrlPath:@"http://192.168.1.112:8080/pgc2/plc_send_serial?"];
    //初始化第一个界面
    [self setupButtonForMyCollectionView0];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    //处理SegmentControl点击
    [segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];

    [self.segmentControl setHidden:YES];
    [self initNYSegmentedControl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  SegmentedControl选择不同的tab呈现不同的界面
 *
 *  @param sender 发送消息的SegmentedControl控件
 */
-(void)segmentControlAction:(UISegmentedControl*)sender{
    NSInteger index = sender.selectedSegmentIndex;
    switch(index){
        case 0:
            [self setupButtonForMyCollectionView0];
            break;
        case 1:
            [self setupButtonForMyCollectionView1];
            break;
        case 2:
            [self setupButtonForMyCollectionView2];
            break;
    }
}

/**
 *  设置回到三国的所有的按钮
 */
-(void)setupButtonForMyCollectionView0{
    self.dataMArr = [NSMutableArray array];
    [self.dataMArr addObject:@{@"text":@"复位",@"down":@"type=click&area=w&address1=000500&val1=01&readOrWrite=write",@"up":@""}];
    [self.dataMArr addObject:@{@"text":@"通道锁1",@"down":@"type=click&area=w&address1=000501&val1=01&readOrWrite=write",@"up":@""}];
    [self.dataMArr addObject:@{@"text":@"通道锁2",@"down":@"type=click&area=w&address1=000502&val1=01&readOrWrite=write",@"up":@""}];
    [self.dataMArr addObject:@{@"text":@"船舱锁",@"down":@"type=click&area=w&address1=000503&val1=01&readOrWrite=write",@"up":@""}];
    [self.dataMArr addObject:@{@"text":@"祭坛锁",@"down":@"type=click&area=w&address1=000504&val1=01&readOrWrite=write",@"up":@""}];
    [self.dataMArr addObject:@{@"text":@"大道锁",@"down":@"type=click&area=w&address1=000505&val1=01&readOrWrite=write",@"up":@""}];
    [self.dataMArr addObject:@{@"text":@"华容道锁",@"down":@"type=click&area=w&address1=000506&val1=01&readOrWrite=write",@"up":@""}];
    [self.dataMArr addObject:@{@"text":@"通关锁",@"down":@"type=click&area=w&address1=000507&val1=01&readOrWrite=write",@"up":@""}];
    [self.dataMArr addObject:@{@"text":@"星阵门开",@"down":@"type=h-bridge&area=w&address1=000600&address2=000700&val1=00&val2=01&readOrWrite=write",@"up":@"type=nomal&area=w&address1=000700&val1=00&readOrWrite=write"}];
    [self.dataMArr addObject:@{@"text":@"星阵门关",@"down":@"type=h-bridge&area=w&address1=000600&address2=000700&val1=01&val2=00&readOrWrite=write",@"up":@"type=nomal&area=w&address1=000600&val1=00&readOrWrite=write"}];
    [self.dataMArr addObject:@{@"text":@"地图门开",@"down":@"type=h-bridge&area=w&address1=000601&address2=000701&val1=00&val2=01&readOrWrite=write",@"up":@"type=nomal&area=w&address1=000701&val1=00&readOrWrite=write"}];
    [self.dataMArr addObject:@{@"text":@"地图门关",@"down":@"type=h-bridge&area=w&address1=000601&address2=000701&val1=01&val2=00&readOrWrite=write",@"up":@"type=nomal&area=w&address1=000601&val1=00&readOrWrite=write"}];
    [self.dataMArr addObject:@{@"text":@"祭坛门开",@"down":@"type=h-bridge&area=w&address1=000602&address2=000702&val1=00&val2=01&readOrWrite=write",@"up":@"type=nomal&area=w&address1=000702&val1=00&readOrWrite=write"}];
    [self.dataMArr addObject:@{@"text":@"祭坛门关",@"down":@"type=h-bridge&area=w&address1=000602&address2=000702&val1=01&val2=00&readOrWrite=write",@"up":@"type=nomal&area=w&address1=000602&val1=00&readOrWrite=write"}];
    
    [self.myCollectionView reloadData];
}

/**
 *  设置三国卧龙的考验的界面
 */
-(void)setupButtonForMyCollectionView1{
    [self.dataMArr removeAllObjects];
    [self.dataMArr addObject:@{@"text":@"卧龙考验",@"down":@"",@"up":@""}];
    [self.myCollectionView reloadData];
}

/**
 *  设置凶宅界面
 */
-(void)setupButtonForMyCollectionView2{
    [self.dataMArr removeAllObjects];
    [self.dataMArr addObject:@{@"text":@"凶宅",@"down":@"",@"up":@""}];
    [self.myCollectionView reloadData];
}

/**
 *  初始化自定义的SegmentedControl
 */
-(void)initNYSegmentedControl{
    
    NYSegmentedControl *sc = [[NYSegmentedControl alloc] initWithItems:@[@"卧龙的考验",@"八阵图",@"凶宅"]];
    //如果要对该控件使用autolayout，必须使translatesAutoresizingMaskIntoConstraints为NO
    //以关闭该控件的Autoresizing的布局功能
    sc.translatesAutoresizingMaskIntoConstraints = NO;
    
    [sc addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    sc.titleTextColor = [UIColor colorWithRed:0.38f green:0.68f blue:0.93f alpha:1.0f];
    sc.titleFont = [UIFont boldSystemFontOfSize:17.0f];
//    CGRect frame = sc.frame;
//    [sc setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 30.0f)];
    sc.selectedTitleTextColor = [UIColor whiteColor];
    sc.selectedTitleFont = [UIFont boldSystemFontOfSize:17.0f];
    sc.segmentIndicatorBackgroundColor =                                        //指示器背景色
    [UIColor colorWithRed:0.38f green:0.68f blue:0.93f alpha:1.0f];
    sc.segmentIndicatorBorderWidth = 0.0f;
    sc.segmentIndicatorInset = 2.0f;                                            //指示器嵌入
    sc.segmentIndicatorBorderColor = self.view.backgroundColor;                 //指示器边框颜色
    
    
    sc.backgroundColor = [UIColor colorWithRed:0.31f green:0.53f blue:0.72f alpha:1.0f];
    sc.borderWidth = 0.0f;
    //    sc.cornerRadius = CGRectGetHeight(sc.frame)/2.0f;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    sc.usesSpringAnimations = YES;
#endif
    [self.view addSubview:sc];
    
    //对该控件进行约束布局，横向与父控件头尾相等，纵向在navigationBar下面myCollectionView上面
    NSMutableArray * segmentConstraints = [NSMutableArray array];
    [segmentConstraints addObjectsFromArray:[NSLayoutConstraint                 //横向约束
                                             constraintsWithVisualFormat:@"H:|-0-[sc]-0-|" options:0 metrics:nil
                                             views:NSDictionaryOfVariableBindings(sc)]];
    [segmentConstraints addObjectsFromArray:[NSLayoutConstraint
                                             constraintsWithVisualFormat:@"V:[navigationBar][sc][myCollectionView]" options:0 metrics:nil views:@{@"sc":sc,@"navigationBar":self.navigationBar,@"myCollectionView":self.myCollectionView}]];
    [self.view addConstraints:segmentConstraints];
 
}


#pragma mark - Collection View Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataMArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *collectionCellID = @"myCollectionViewCell";
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    NSDictionary *dic = self.dataMArr[indexPath.row];

//    [cell.button setTitle:dic[@"text"] forState:UIControlStateNormal];
    [cell.label setText:dic[@"text"]];
    [cell.button.layer setCornerRadius:35.0f];
    [cell.button setImage:[UIImage imageNamed:@"Resources/bt_icon1.png"] forState:UIControlStateNormal];
    cell.upcmd = dic[@"up"];
    cell.downcmd = dic[@"down"];
    [cell.button addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [cell.button addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

-(void)touchDown:(UIButton*)sender{
//    sender.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:170.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    if([sender.superview.superview isKindOfClass:[MyCollectionViewCell class]]){
        MyCollectionViewCell *cell = (MyCollectionViewCell *)(sender.superview.superview);
        if(![cell.downcmd isEqualToString:@""]){
            [http sendCommand:cell.downcmd];
        }
    }
}

-(void)touchUp:(UIButton*)sender{
//        sender.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    if([sender.superview.superview isKindOfClass:[MyCollectionViewCell class]]){
        MyCollectionViewCell *cell = (MyCollectionViewCell *)(sender.superview.superview);
        if(![cell.upcmd isEqualToString:@""]){
            [http sendCommand:cell.upcmd];
        }
    }
}






















@end
