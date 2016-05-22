//
//  ViewController.m
//  BK42iOSManager
//
//  Created by chong feng on 15/12/3.
//  Copyright © 2015年 chong feng. All rights reserved.
//

#import "ViewController.h"
#import "UITextImage.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize segmentControl;
@synthesize leftSwipeGestureRecognizer,rightSwipeGestureRecognizer;

NetHttpUtils *http;                                                             //用于通讯的http对象
UIImage *imgDumpIsReady;                                                        //敲鼓状态准备好的绿色按钮
UIImage *imgDumpIsNotReady;                                                     //敲鼓状态未准备好的红色按钮
NSArray<NSString*> *urlPathArray;                                               //保存每个tab用到的服务器地址

- (void)viewDidLoad {
    [super viewDidLoad];
    //3个地址分别为《卧龙的考验》、《八阵图》、《凶宅》的服务器地址
    urlPathArray = [NSArray arrayWithObjects:@"http://192.168.1.112:8080/pgc2/",
                       @"http://192.168.1.113:8080/pgc2/",
                       @"http://192.168.1.111:8080/pgc2/",nil];
    
    //设置服务器路径,默认为第一个界面的路径
    //    http = [[NetHttpUtils alloc] initWithUrlPath:@"http://192.168.199.202:8080/pgc2/"];
    http = [[NetHttpUtils alloc] initWithUrlPath:urlPathArray[0]];
    http.delegate = self;                                                       //设置http的委托对象
    //初始化按钮的两个状态图片
    imgDumpIsReady = [UIImage imageNamed:@"dumpIsReady.png"];
    imgDumpIsNotReady = [UIImage imageNamed:@"dumpIsNotReady.png"];
    //初始化数组
    self.dataMArr = [NSMutableArray array];
    
    //初始化第一个界面
    [self setupButtonForMyCollectionView0];
    self.myCollectionView.stateCells = [[NSMutableArray alloc]init];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    //处理SegmentControl点击
    [segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.segmentControl setHidden:YES];
    [self initNYSegmentedControl];
    
    //设置下拉刷新操作，块中的内容表示下拉刷新后要做的操作
    MJRefreshStateHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        NSMutableArray *cells = self.myCollectionView.stateCells;
        for (NSInteger i=0; i<cells.count; i++) {
            MyCollectionViewCell *cell = cells[i];
            if(cell.cellType==TYPESTATE && ![cell.downcmd isEqualToString:@""]){
                [http sendCommand:cell.downcmd sender:cell];
            }
        }
        [self.myCollectionView.mj_header endRefreshing];
    }];
    self.myCollectionView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    //设置手势处理
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  SegmentedControl选择不同的tab呈现不同的界面
 *  @param sender 发送消息的SegmentedControl控件
 */
-(void)segmentControlAction:(UISegmentedControl*)sender{
    NSInteger index = sender.selectedSegmentIndex;
    switch(index){
        case 0:
            [self setupButtonForMyCollectionView0];
            [self.myCollectionView.mj_header executeRefreshingCallback];        //执行刷新的操作
            break;
        case 1:
            [self setupButtonForMyCollectionView1];
            [self.myCollectionView.mj_header executeRefreshingCallback];        //执行刷新的操作
            break;
        case 2:
            [self setupButtonForMyCollectionView2];
            [self.myCollectionView.mj_header executeRefreshingCallback];        //执行刷新的操作
            break;
    }
}



/**
 *  设置卧龙的考验的所有的按钮
 */
-(void)setupButtonForMyCollectionView0{
    http.urlpath = urlPathArray[0];
    [self.dataMArr removeAllObjects];
    [self.dataMArr addObject:@{@"text":@"敲鼓状态",@"down":@"plc_state_query?point=dumpIsReady",@"up":@"",@"type":@"state"}];
    [self.dataMArr addObject:@{@"text":@"复位",@"down":@"",@"up":[http makeClickWWriteURL:@"000500" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"通道锁1",@"down":@"",@"up":[http makeClickWWriteURL:@"000501" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"通道锁2",@"down":@"",@"up":[http makeClickWWriteURL:@"000502" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"船舱锁",@"down":@"",@"up":[http makeClickWWriteURL:@"000503" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"祭坛锁",@"down":@"",@"up":[http makeClickWWriteURL:@"000504" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"大道锁",@"down":@"",@"up":[http makeClickWWriteURL:@"000505" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"华容道锁",@"down":@"",@"up":[http makeClickWWriteURL:@"000506" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"通关锁",@"down":@"",@"up":[http makeClickWWriteURL:@"000507" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"星阵门开",@"down":@"plc_send_serial?type=h-bridge&area=w&address1=000600&address2=000700&val1=00&val2=01&readOrWrite=write"
                               ,@"up":@"plc_send_serial?type=nomal&area=w&address1=000700&val1=00&readOrWrite=write"}];
    [self.dataMArr addObject:@{@"text":@"星阵门关",@"down":@"plc_send_serial?type=h-bridge&area=w&address1=000600&address2=000700&val1=01&val2=00&readOrWrite=write",@"up":@"plc_send_serial?type=nomal&area=w&address1=000600&val1=00&readOrWrite=write"}];
    [self.dataMArr addObject:@{@"text":@"地图门开",@"down":@"plc_send_serial?type=h-bridge&area=w&address1=000601&address2=000701&val1=00&val2=01&readOrWrite=write",@"up":@"plc_send_serial?type=nomal&area=w&address1=000701&val1=00&readOrWrite=write"}];
    [self.dataMArr addObject:@{@"text":@"地图门关",@"down":@"plc_send_serial?type=h-bridge&area=w&address1=000601&address2=000701&val1=01&val2=00&readOrWrite=write",@"up":@"plc_send_serial?type=nomal&area=w&address1=000601&val1=00&readOrWrite=write"}];
    [self.dataMArr addObject:@{@"text":@"祭坛门开",@"down":@"plc_send_serial?type=h-bridge&area=w&address1=000602&address2=000702&val1=00&val2=01&readOrWrite=write",@"up":@"plc_send_serial?type=nomal&area=w&address1=000702&val1=00&readOrWrite=write"}];
    [self.dataMArr addObject:@{@"text":@"祭坛门关",@"down":@"plc_send_serial?type=h-bridge&area=w&address1=000602&address2=000702&val1=01&val2=00&readOrWrite=write",@"up":@"plc_send_serial?type=nomal&area=w&address1=000602&val1=00&readOrWrite=write"}];

    [self.myCollectionView.stateCells removeAllObjects];
    [self.myCollectionView reloadData];
}

/**
 *  设置八阵图的界面
 */
-(void)setupButtonForMyCollectionView1{
    http.urlpath = urlPathArray[1];
    [self.dataMArr removeAllObjects];
//    [self.dataMArr addObject:@{@"text":@"复位",@"down":@"",@"up":[http makeClickWWriteURL:@"000500" addValue:@"01"]}];
    //此处按下与抬起做了两个操作，按下复位5.00点，抬起设置5.10点用来复位若干W点
    [self.dataMArr addObject:@{@"text":@"复位",@"down":[http makeClickWWriteURL:@"000500" addValue:@"01"],@"up":[http makeClickWWriteURL:@"00050A" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"七星灯",@"down":@"plc_state_query?point=",@"up":@"",@"type":@"number"}];
    [self.dataMArr addObject:@{@"text":@"大门开",@"down":@"",@"up":[http makeClickWWriteURL:@"00070D" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"续命灯开",@"down":@"",@"up":[http makeClickWWriteURL:@"000501" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"续命复位",@"down":@"",@"up":[http makeClickWWriteURL:@"000601" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"朱雀门开",@"down":@"",@"up":[http makeClickWWriteURL:@"000700" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"朱雀通道",@"down":@"",@"up":[http makeClickWWriteURL:@"000701" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"朱雀武器",@"down":@"",@"up":[http makeClickWWriteURL:@"000702" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"朱雀通关",@"down":@"",@"up":[http makeClickWWriteURL:@"000708" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"白虎门",@"down":@"",@"up":[http makeClickWWriteURL:@"000703" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"白虎铁链",@"down":@"",@"up":[http makeClickWWriteURL:@"000704" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"车零件1",@"down":@"",@"up":[http makeClickWWriteURL:@"000705" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"车零件2",@"down":@"",@"up":[http makeClickWWriteURL:@"000706" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"白虎武器",@"down":@"",@"up":[http makeClickWWriteURL:@"000709" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"玄武门",@"down":@"",@"up":[http makeClickWWriteURL:@"000707" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"分贝通关",@"down":@"",@"up":[http makeClickWWriteURL:@"000408" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"玄武酒坛",@"down":@"",@"up":[http makeClickWWriteURL:@"000509" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"玄武武器",@"down":@"",@"up":[http makeClickWWriteURL:@"00070A" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"青龙沙盘",@"down":@"",@"up":[http makeClickWWriteURL:@"00070B" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"青龙通道",@"down":@"",@"up":[http makeClickWWriteURL:@"00070C" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"青龙武器",@"down":@"",@"up":[http makeClickWWriteURL:@"00070F" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"大厅印升",@"down":[http makeHBWWriteURL:@"000505" addValue1:@"01" address2:@"000605" addValue2:@"00"],@"up":[http makeNomalWWrite:@"000505" addValue:@"00"]}];
    [self.dataMArr addObject:@{@"text":@"大厅印降",@"down":[http makeHBWWriteURL:@"000605" addValue1:@"01" address2:@"000505" addValue2:@"00"],@"up":[http makeNomalWWrite:@"000605" addValue:@"00"]}];
    [self.dataMArr addObject:@{@"text":@"白虎车退",@"down":[http makeHBWWriteURL:@"000603" addValue1:@"01" address2:@"000503" addValue2:@"00"],@"up":[http makeNomalWWrite:@"000603" addValue:@"00"]}];
    [self.dataMArr addObject:@{@"text":@"白虎车进",@"down":[http makeHBWWriteURL:@"000503" addValue1:@"01" address2:@"000603" addValue2:@"00"],@"up":[http makeNomalWWrite:@"000503" addValue:@"00"]}];
    [self.dataMArr addObject:@{@"text":@"玄武桥升",@"down":[http makeHBWWriteURL:@"000604" addValue1:@"01" address2:@"000504" addValue2:@"00"],@"up":[http makeNomalWWrite:@"000604" addValue:@"00"]}];
    [self.dataMArr addObject:@{@"text":@"玄武桥降",@"down":[http makeHBWWriteURL:@"000504" addValue1:@"01" address2:@"000604" addValue2:@"00"],@"up":[http makeNomalWWrite:@"000504" addValue:@"00"]}];
    
    [self.myCollectionView.stateCells removeAllObjects];
    [self.myCollectionView reloadData];
}

/**
 *  设置凶宅界面
 */
-(void)setupButtonForMyCollectionView2{
    NSLog(@"setupButtonForMyCollectionView2");
    http.urlpath = urlPathArray[2];
    [self.dataMArr removeAllObjects];
    [self.dataMArr addObject:@{@"text":@"浇花状态",@"down":@"plc_state_query?point=i0.11",@"up":@"",@"type":@"state",@"back":@"YES"}];
    [self.dataMArr addObject:@{@"text":@"敲门状态",@"down":@"plc_state_query?point=i0.09",@"up":@"",@"type":@"state"}];
    [self.dataMArr addObject:@{@"text":@"复位",@"down":@"",@"up":[http makeClickWWriteURL:@"000100" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"脚踏灯亮",@"down":@"",@"up":[http makeClickWWriteURL:@"000505" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"通风口开",@"down":@"",@"up":[http makeClickWWriteURL:@"00010A" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"梳妆台锁",@"down":@"",@"up":[http makeClickWWriteURL:@"000700" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"娃娃区锁",@"down":@"",@"up":[http makeClickWWriteURL:@"000600" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"投影仪亮",@"down":@"",@"up":[http makeClickWWriteURL:@"00010C" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"屏风门开",@"down":@"",@"up":[http makeClickWWriteURL:@"00010B" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"四画灯灭",@"down":@"",@"up":[http makeClickWWriteURL:@"000601" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"掉画上电",@"down":@"",@"up":[http makeClickWWriteURL:@"000602" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"女鬼音效",@"down":@"",@"up":[http makeClickWWriteURL:@"000800" addValue:@"01"]}];
    [self.dataMArr addObject:@{@"text":@"床抽屉回",@"down":[http makeHBWWriteURL:@"000000" addValue1:@"01" address2:@"000200" addValue2:@"00"],@"up":[http makeNomalWWrite:@"000000" addValue:@"00"]}];
    [self.dataMArr addObject:@{@"text":@"床抽屉出",@"down":[http makeHBWWriteURL:@"000200" addValue1:@"01" address2:@"000000" addValue2:@""],@"up":[http makeNomalWWrite:@"000200" addValue:@"00"]}];
    [self.dataMArr addObject:@{@"text":@"结婚照开",@"down":[http makeHBWWriteURL:@"000201" addValue1:@"01" address2:@"000001" addValue2:@"00"],@"up":[http makeNomalWWrite:@"000201" addValue:@"00"]}];
    [self.dataMArr addObject:@{@"text":@"结婚照关",@"down":[http makeHBWWriteURL:@"000001" addValue1:@"01" address2:@"000201" addValue2:@"00"],@"up":[http makeNomalWWrite:@"000001" addValue:@"00"]}];
    [self.dataMArr addObject:@{@"text":@"女鬼回",@"down":[http makeHBWWriteURL:@"000004" addValue1:@"01" address2:@"000003" addValue2:@"00"],@"up":[http makeNomalWWrite:@"000004" addValue:@"00"]}];
    [self.dataMArr addObject:@{@"text":@"女鬼出",@"down":[http makeHBWWriteURL:@"000003" addValue1:@"01" address2:@"000004" addValue2:@"00"],@"up":[http makeNomalWWrite:@"000003" addValue:@"00"]}];
    
    [self.myCollectionView.stateCells removeAllObjects];
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
/**
 *  根据代理数据实现按钮的方法
 *  @param collectionView 要实现的集合中的view
 *  @param indexPath      标识当前cell的坐标，表示在第section中的第几row
 *  @return 返回集合中的当前的view
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%@",indexPath);
    
    static NSString *collectionCellID = @"myCollectionViewCell";
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    NSDictionary *dic = self.dataMArr[indexPath.row];

//    [cell.button setTitle:dic[@"text"] forState:UIControlStateNormal];
    [cell.label setText:dic[@"text"]];
    [cell.button.layer setCornerRadius:35.0f];
    cell.upcmd = dic[@"up"];
    cell.downcmd = dic[@"down"];
    
    if(dic[@"type"]==nil ){
        cell.cellType = TYPEBUTTON;                                             //设置cell类型为按钮
        //当代理数据为的类型为空，默认为button；代理数据类型不为state，类型为button
        [cell.button setBackgroundImage:[UIImage imageNamed:@"bt_icon1.png"] forState:UIControlStateNormal];
        [cell.button addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [cell.button addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if([dic[@"type"] isEqualToString:@"number"]){
        cell.cellType = TYPENUMBER;
        [cell.button setBackgroundImage:[UITextImage imageNamed:@"bt_icon1.png"] forState:UIControlStateNormal];
//        [cell.button setBackgroundImage:[[UITextImage alloc] init] forState:UIControlStateNormal];
        [cell.button addTarget:self action:@selector(numberTouch:) forControlEvents:UIControlEventTouchDown];
    }
    else if([dic[@"type"] isEqualToString:@"state"]){
        cell.cellType = TYPESTATE;                                              //设置cell类型为状态
        if(dic[@"back"]!=nil && [dic[@"back"] isEqualToString:@"YES"])
            cell.stateBack = YES;                                               //如果取反状态将取反状态标识设置为YES
        else
            cell.stateBack = NO;
        cell.button.layer.borderColor = [UIColor grayColor].CGColor;
        cell.button.layer.borderWidth = 2;
        cell.button.layer.masksToBounds = YES;
        [cell.button setBackgroundImage:imgDumpIsNotReady forState:UIControlStateNormal];
        [cell.button addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        
        [self.myCollectionView.stateCells addObject:cell]; //将state cell加入stateCells数组
    }
    return cell;
}

/**
 *  要想显示出CollectionView中的footer或者header需要实现以下方法
 *
 *  @param collectionView CollectionView对象
 *  @param kind           <#kind description#>
 *  @param indexPath      <#indexPath description#>
 *
 *  @return <#return value description#>
 */
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
//    MyCollectionReusableView *reusableview = nil;
//    if(kind == UICollectionElementKindSectionHeader){
//        UICollectionReusableView *headerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
//        //获得header视图
//        reusableview = (MyCollectionReusableView *)headerview;
//        //设置显示鼓状态的label
//        labelDumpIsReady = reusableview.labelDumpIsReady;
//        reusableview.labelDumpIsReady.layer.backgroundColor = [UIColor colorWithRed:0.8f green:0.2f blue:0.2f alpha:1.0f].CGColor;
//        reusableview.labelDumpIsReady.layer.cornerRadius = 22;
//        reusableview.labelDumpIsReady.layer.borderWidth = 2;
//        reusableview.labelDumpIsReady.layer.borderColor = [UIColor grayColor].CGColor;
//        
//        //设置标题label的样式
//        reusableview.labelTitle.layer.backgroundColor=[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f].CGColor;
//        reusableview.labelTitle.layer.cornerRadius = 8;
//        reusableview.labelTitle.layer.borderWidth = 2;
//        reusableview.labelTitle.layer.borderColor = [UIColor grayColor].CGColor;
//
//    }
//    return reusableview;
//}
/**
 *  普通按钮按下操作
 *
 *  @param sender 发送消息的对象
 */
-(void)touchDown:(UIButton*)sender{
//    sender.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:170.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    if([sender.superview.superview isKindOfClass:[MyCollectionViewCell class]]){
        MyCollectionViewCell *cell = (MyCollectionViewCell *)(sender.superview.superview);
        if(![cell.downcmd isEqualToString:@""]){
            
            [http sendCommand:cell.downcmd sender:cell];
        }
    }
}
/**
 *  普通按钮抬起操作
 *
 *  @param sender 发送消息的对象
 */
-(void)touchUp:(UIButton*)sender{
//        sender.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    if([sender.superview.superview isKindOfClass:[MyCollectionViewCell class]]){
        MyCollectionViewCell *cell = (MyCollectionViewCell *)(sender.superview.superview);
        if(![cell.upcmd isEqualToString:@""]){
            [http sendCommand:cell.upcmd sender:cell];
        }
    }
}

int starCount = 0;
int starSum = 0;
-(void)numberTouch:(UIButton*)sender{
    if([sender.superview.superview isKindOfClass:[MyCollectionViewCell class]]){
        MyCollectionViewCell *cell = (MyCollectionViewCell *)(sender.superview.superview);
        if(![cell.downcmd isEqualToString:@""]){
//            [http sendCommand:cell.downcmd sender:cell];
//            NSString *urlpath = pUrlPath +cell.downcmd;

            
            for (int i=0; i<7; i++) {
                
                NSURL *fullUrl = [NSURL URLWithString:[[[http.urlpath stringByAppendingString:cell.downcmd] stringByAppendingString:@"O101.0"] stringByAppendingString:[NSString stringWithFormat:@"%d",i]]];
                
                NSLog(@"%@",fullUrl);
                NSURLRequest *request = [NSURLRequest requestWithURL:fullUrl];
                NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
                config.timeoutIntervalForRequest = 3;
                config.timeoutIntervalForResource = 3;
                NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
                
                //    NSURLSession *session = [NSURLSession sharedSession];
                //    session.configuration.timeoutIntervalForResource = 3;
                NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                        completionHandler:
                                              ^(NSData *data,NSURLResponse *response,NSError *error){

                                                  NSString * sdata = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                  NSLog(@"receiveData:%@",sdata);
                                                  if([sdata isEqualToString:@"true"]){
                                                      starSum++;
                                                  }
                                                  starCount++;
                                                  
                                                  //如果7次数据全部返回做最后操作
                                                  if(starCount==7){
                                                      if(starSum==0){
                                                          [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
                                                              [cell.button setBackgroundImage:[UIImage imageNamed:@"bt_alaphicon.png"] forState:UIControlStateNormal];
                                                          }]];
                                                      }else{
                                                          [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
                                                              [cell.button setBackgroundImage:[UIImage imageNamed:[[NSString stringWithFormat:@"%d", starSum] stringByAppendingString:@".png"]] forState:UIControlStateNormal];
                                                          }]];
                                                      }
                                                      starCount = 0;
                                                      starSum = 0;
                                                      NSLog(@"starSum:%@",[[NSString stringWithFormat:@"%d", starSum] stringByAppendingString:@".png"]);
                                                  }
                                              }];
                [task resume];

            }
            

            
            
        }
    }
}

/**
 *  当鼓状态请求返回数据时做如下处理
 *  @param data 向http服务器请求返回的数据
 */
-(void)receiveData:(NSString *)data sender:sender{
    NSLog(@"receiveData:%@",data);
    MyCollectionViewCell* cell = sender;
    if([data isEqualToString:@"false"]){
        [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
            if(!cell.stateBack)
                [cell.button setBackgroundImage:imgDumpIsNotReady forState:UIControlStateNormal];
            else
                [cell.button setBackgroundImage:imgDumpIsReady forState:UIControlStateNormal];
        }]];
    }else if([data isEqualToString:@"true"]){
        [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
            if(!cell.stateBack)
                [cell.button setBackgroundImage:imgDumpIsReady forState:UIControlStateNormal];
            else
                [cell.button setBackgroundImage:imgDumpIsNotReady forState:UIControlStateNormal];
        }]];
    }
}

/**
 *  处理手势函数
 *  @param sender 手势消息的发送者
 */
-(void)handleSwipes:(UISwipeGestureRecognizer *)sender{
    if(sender.direction==UISwipeGestureRecognizerDirectionLeft){
        [self.segmentControl setSelectedSegmentIndex:1];
//        [self.segmentControl setSelectedSegmentIndex:1 animated:YES];
        NSLog(@"left-------->");
    }
    if(sender.direction==UISwipeGestureRecognizerDirectionRight){
                [self.segmentControl setSelectedSegmentIndex:2];
//        [self.segmentControl setSelectedSegmentIndex:0 animated:YES];
        NSLog(@"<--------right");
    }
}


















@end
