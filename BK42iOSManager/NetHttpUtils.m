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
@synthesize urlpath;
NSString *action;

/**
 *  带入urlpath参数的初始化函数
 *
 *  @param pUrlPath 包括url和必要的路径,例如http://192.168.1.112:8080/pgc2/
 *
 *  @return 返回一个NetHttpUtils对象
 */
-(id)initWithUrlPath:(NSString *)pUrlPath{
    if(self=[super init]){
//        urlpath = [pUrlPath copy];
        urlpath = pUrlPath;
        action = @"plc_send_serial";
    }
    return self;
}

/**
 *  发送指令
 *
 *  @param command 指令内容
 */
-(void)sendCommand:(NSString *)command sender:(NSObject *)sender{
    //NSURLConnection方式处理
//    NSString *urlPathCommand = [urlpath stringByAppendingString:command];
//    NSURL *url = [NSURL URLWithString:urlPathCommand];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [NSURLConnection connectionWithRequest:request delegate:self];
    
    //NSURLSession方式处理
    NSURL *url = [NSURL URLWithString:[urlpath stringByAppendingString:command]];
//    NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 3;
    config.timeoutIntervalForResource = 3;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
//    NSURLSession *session = [NSURLSession sharedSession];
//    session.configuration.timeoutIntervalForResource = 3;
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data,NSURLResponse *response,NSError *error){
                                      [self.delegate receiveData:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] sender:sender];
                                  }];
    [task resume];
}
/**
 *  按钮为点击类型，向w区某地址写入数据
 *
 *  @param address 要写入的地址，一般格式为“000500”，表示地址5.00，前4位表示地址5，后2位表示16位通道
 *  @param val     要写入的值，一般为“00”或“01”
 *
 *  @return 返回要生成的url字符串
 */
-(NSString*)makeClickWWriteURL:(NSString *)address addValue:(NSString *)val{
    NSString *retval = @"";
    [retval stringByAppendingString:action];
    [retval stringByAppendingString:@"?type=click&area=w&address1="];
    [retval stringByAppendingString:address];
    [retval stringByAppendingString:@"&val1="];
    [retval stringByAppendingString:val];
    [retval stringByAppendingString:@"&readOrWrite=write"];
    return retval;
}
/**
 *  h桥电路接通，需要设置两个地址的值
 *
 *  @param address1 第一个地址
 *  @param val1     第一个地址的值
 *  @param address2 第二个地址
 *  @param val2     第二个地址的值
 *
 *  @return 返回生成的url
 */
-(NSString*)makeHBWWriteURL:(NSString *)address1 addValue1:(NSString *)val1 address2:(NSString *)address2 addValue2:(NSString *)val2{
    NSString *retval = @"";
    [retval stringByAppendingFormat:@"%@?type=h-bridge&area=w&address1=%@&address2=%@&val1=%@&val2=%@&readOrWrite=write"
     ,action,address1,address2,val1,val2];
    return retval;
}
/**
 *  当h桥类持续按的功能恢复后执行的操作
 *
 *  @param address 要恢复的第一个地址
 *  @param val     恢复第一个地址的值
 *
 *  @return 返回生成的URL
 */
-(NSString*)makeNomalWWrite:(NSString *)address addValue:(NSString *)val{
    NSString *retval = @"";
    [retval stringByAppendingFormat:@"%@?type=nomal&area=w&address1=%@&val1=%@&readOrWrite=write"
     ,action,address,val];
    return retval;
}
#pragma mark
-(void)connection:(NSURLConnection*)connection didReceiveResponse:(nonnull NSURLResponse *)response{}
-(void)connection:(NSURLConnection*)connection didReceiveData:(nonnull NSData *)data{
    //将数据转为字符串发送
//    [self.delegate receiveData:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
}
-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error{}
-(void)connectionDidFinishLoading:(NSURLConnection*)connection{
}

@end

































