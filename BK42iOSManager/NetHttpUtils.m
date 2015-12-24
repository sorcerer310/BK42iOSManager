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
 *  @param pUrlPath 包括url和必要的路径,例如http://192.168.1.112:8080/pgc2/
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
    //NSURLConnection方式处理
//    NSString *urlPathCommand = [urlpath stringByAppendingString:command];
//    NSURL *url = [NSURL URLWithString:urlPathCommand];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [NSURLConnection connectionWithRequest:request delegate:self];
    
    //NSURLSession方式处理
    NSURL *url = [NSURL URLWithString:[urlpath stringByAppendingString:command]];
//    NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data,NSURLResponse *response,NSError *error){
                                      [self.delegate receiveData:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
//                                      NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                  }];
    [task resume];
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

































