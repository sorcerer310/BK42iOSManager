//
//  MyCollectionViewCell.h
//  BK42iOSManager
//
//  Created by chong feng on 15/12/3.
//  Copyright © 2015年 chong feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (copy, nonatomic) NSString *upcmd;
@property (copy,nonatomic) NSString *downcmd;
@end
