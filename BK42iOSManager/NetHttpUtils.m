//
//  NetHttpUtils.m
//  BK42iOSManager
//
//  Created by chong feng on 15/12/2.
//  Copyright © 2015年 chong feng. All rights reserved.
//

#import "NetHttpUtils.h"

@implementation NetHttpUtils
@synthesize delegate;

/**
 *  带入urlpath参数的初始化函数
 *
 *  @param pUrlPath 包括url和必要的路径,例如http://192.168.1.112:8080/pgc2/plc_send_serial?
 *
 *  @return 返回一个NetHttpUtils对象
 */
-(id)initWithUrlPath:(NSString *)pUrlPath{
    if(self=[super init]){
        urlpath = [pUrlPath copy];
    }
    return self;
}

/**
 *  发送指令
 *
 *  @param command 指令内容
 */
-(void)sendCommand:(NSString *)command{
    NSString *urlPathCommand = [urlpath stringByAppendingString:command];
    NSURL *url = [NSURL URLWithString:urlPathCommand];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
//    NSLog([urlpath stringByAppendingString:command]);
}

#pragma mark
-(void)connection:(NSURLConnection*)connection didReceiveResponse:(nonnull NSURLResponse *)response{}
-(void)connection:(NSURLConnection*)connection didReceiveData:(nonnull NSData *)data{
    //将数据转为字符串发送
    [self.delegate receiveData:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
}
-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error{}
-(void)connectionDidFinishLoading:(NSURLConnection*)connection{}

@end

































