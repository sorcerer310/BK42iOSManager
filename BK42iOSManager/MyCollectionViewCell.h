//
//  MyCollectionViewCell.h
//  BK42iOSManager
//
//  Created by chong feng on 15/12/3.
//  Copyright © 2015年 chong feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *button;                          //该单元的按钮
@property (weak, nonatomic) IBOutlet UILabel *label;                            //该单元显示的文字标签
@property (copy, nonatomic) NSString *upcmd;                                    //该单元抬起发送的url指令
@property (copy,nonatomic) NSString *downcmd;                                   //该单元按下发送的url指令

typedef enum{                                                                   //区分该单元表示的是一个按钮还是一个状态指示
    TYPEBUTTON,
    TYPESTATE
} CellType;
@property (nonatomic) CellType cellType;                                        //保存该单元类型值
@property (nonatomic) BOOL stateBack;                                           //有的状态需要取反获得true时显示失败，获得false时显示成功，
                                                                                //该值为YES时，状态表示取反
@end
