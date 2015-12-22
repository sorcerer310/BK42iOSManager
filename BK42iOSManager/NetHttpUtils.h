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
-(void)receiveData:(NSString *)data;
@end

@interface NetHttpUtils:NSObject{
NSString *urlpath;
}
@property (nonatomic,weak)id<NetHttpUtilsDelegate> delegate;

-(id)initWithUrlPath:(NSString *)urlPath;
-(void)sendCommand:(NSString *)command;

@end

