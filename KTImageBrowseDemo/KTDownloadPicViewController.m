//
//  KTDownloadPicViewController.m
//  KTImageBrowse
//
//  Created by KT on 15/9/18.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "KTDownloadPicViewController.h"
#import "KTImageData.h"
#import "SVProgressHUD.h"


@interface KTDownloadPicViewController ()
{
    long long _expectedLength;/**<数据结构长度*/
    long long _currentLength;/**<已经接收数据长度*/
    NSMutableData *_mutdata;/**<临时可变数据*/
    NSInteger _currentIndex;/**<图片现在位置*/
}
@property (nonatomic, strong) NSData *imageResult;
@property (nonatomic, assign) BOOL isShowHUD;
@end

@implementation KTDownloadPicViewController

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _imageResult = [[NSData alloc] init];
        _mutdata = [[NSMutableData alloc] init];
    }
    return self;
}


#pragma mark - public methods
/**
 *  不带菊花下载图片
 *
 *  @param urlString 图片URL
 *  @param block     finish block
 */
- (void)downloadPicWithURLSting:(NSString *)urlString
                    finishBlock:(FinishBlick)block
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.finishBlock = block;
    _isShowHUD = NO;
    [connection start];
}

/**
 *  带菊花下载图片
 *
 *  @param urlString 图片URL
 *  @param block     finish block
 */
- (void)downloadPicWithURLStingWithProgress:(NSString *)urlString
                                finishBlock:(FinishBlick)block

{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.finishBlock = block;
    _isShowHUD = YES;
    [connection start];
}

#pragma mark - NSURLConntctionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (_isShowHUD) {
        _expectedLength = [response expectedContentLength];
        _currentLength = 0;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (_isShowHUD) {
        _currentLength += [data length];
        [SVProgressHUD showProgress:_currentLength / (float)_expectedLength];
    }
    [_mutdata appendData:data];
    _imageResult = _mutdata;

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (_isShowHUD) {
        [SVProgressHUD showSuccessWithStatus:@"下载成功"];
    }
    //数据结果block回调
    self.finishBlock(_imageResult);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (_isShowHUD) {
        [SVProgressHUD showErrorWithStatus:@"网络中断"];
    }
}



@end
