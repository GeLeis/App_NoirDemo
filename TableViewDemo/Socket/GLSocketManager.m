//
//  GLSocketManager.m
//  TableViewDemo
//
//  Created by gelei on 2020/7/23.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "GLSocketManager.h"
#import <GCDAsyncSocket.h>
#import "GLCommonHeader.h"
@interface GLSocketManager ()<GCDAsyncSocketDelegate>
@property (nonatomic, strong) dispatch_queue_t delegatequeue;
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;
@end

@implementation GLSocketManager

static GLSocketManager *_manager = nil;

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[GLSocketManager alloc] init];
        _manager.delegatequeue = dispatch_queue_create("com.gelei.socket.delegatequeue", DISPATCH_QUEUE_CONCURRENT);
    });
    return _manager;
}

/*
* [asyncSocket setDelegate:nil];
* [asyncSocket disconnect];
* [asyncSocket release];
*
* If you plan on disconnecting the socket, and then immediately asking it to connect again,
* you'll likely want to do so like this:
* [asyncSocket setDelegate:nil];
* [asyncSocket disconnect];
* [asyncSocket setDelegate:self];
* [asyncSocket connect...];
*/

/**
 建立连接 ,
 在终端执行nc -lk 12345 这样可以开启对tcp端口12345的监听,
 在终端同样可以输入信息,如果已经建立连接,那么客户端可以收到
*/
- (void)connect {
    if ([self.clientSocket isConnected]) {
        self.clientSocket.delegate = nil;
        [self.clientSocket disconnect];
    }
    self.clientSocket.delegate = self;
    NSError *error = nil;
    //tcp连接安全,可靠,但是带来的服务端承载压力大
    //一般情况下,server端单机最大tcp并发连接数超过10万
    [self.clientSocket connectToHost:@"127.0.0.1" onPort:12345 error:&error];
    if (error) {
        DDLogError(@"connect error = %@",error.description);
    } else {
        //连接成功后建立心跳机制,3~5分钟
        //网络在链路上一段时间内没有数据通信之后,会淘汰NAT表中对应项,造成链路中断
        
    }
}

- (void)disconnect {
    self.clientSocket.delegate = nil;
    [self.clientSocket disconnect];
}
//发送消息
- (void)sendMessage:(NSString *)message {
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    // withTimeout -1 : 无穷大,一直等
    // tag : 消息标记
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
}

- (GCDAsyncSocket *)clientSocket {
    if (!_clientSocket) {
        _clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:_manager.delegatequeue];
    }
    return _clientSocket;
}


#pragma mark -- GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    DDLogInfo(@"链接成功");
    DDLogInfo(@"服务器IP: %@-------端口: %d",host,port);
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    DDLogInfo(@"发送数据 tag = %zi",tag);
    [sock readDataWithTimeout:-1 tag:tag];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    DDLogInfo(@"读取数据 data = %@ tag = %zi",str,tag);
    // 读取到服务端数据值后,能再次读取
    [sock readDataWithTimeout:- 1 tag:tag];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    DDLogInfo(@"断开连接");
    self.clientSocket.delegate = nil;
    self.clientSocket = nil;
}
@end
