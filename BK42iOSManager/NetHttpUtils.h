//
//  NetHttpUtils.h
//  BK42iOSManager
//
//  Created by chong feng on 15/12/2.
//  Copyright © 2015年 chong feng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NetHttpUtils;
@protocol NetHttpUtilsDelegate
-(void)receiveData:(NSString *)data sender:(NSObject *)sender;
@end

@interface NetHttpUtils:NSObject{
NSString *urlpath;
}
@property (nonatomic,weak)id<NetHttpUtilsDelegate> delegate;
@property NSString *urlpath;                                                    //请求的服务器地址

-(id)initWithUrlPath:(NSString *)urlPath;                                       //初始化访问路径
-(void)sendCommand:(NSString *)command sender:(NSObject *)sender;               //发送命令
-(NSString*)makeClickWWriteURL:(NSString *)address addValue:(NSString*)val;     //生成点击操作类型向W区写入数据的URL
-(NSString *)makeHBWWriteURL:(NSString*)address1                                //生成H桥电路向W区写入数据的URL
                   addValue1:(NSString*)val1
                    address2:(NSString*)address2
                   addValue2:(NSString*)val2;
-(NSString*)makeNomalWWrite:(NSString*)address addValue:(NSString*)val;         //H桥类持续按功能恢复后执行的操作
@end

