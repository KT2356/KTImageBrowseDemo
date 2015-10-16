//
//  KTDownloadPicViewController.m
//  KTImageBrowse
//
//  Created by KT on 15/9/18.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "KTDownloadPicViewController.h"
#import "KTImageData.h"


@interface KTDownloadPicViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *_HUD;/**<菊花*/
    long long _expectedLength;/**<数据结构长度*/
    long long _currentLength;/**<已经接收数据长度*/
    NSMutableData *_mutdata;/**<临时可变数据*/
    NSTimer *_mytimer;/**<定时器*/
    NSInteger _currentIndex;/**<图片现在位置*/
}
@property (nonatomic, strong) NSData *imageResult;
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
//不带菊花下载图片
- (void)downloadPicWithURLSting:(NSString *)urlString
                    finishBlock:(FinishBlick)block
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.finishBlock = block;
    [connection start];
}

//带菊花下载图片
- (void)downloadPicWithURLStingWithProgress:(NSString *)urlString
                                finishBlock:(FinishBlick)block

{
    
    _HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow.rootViewController.view  animated:YES];
    _HUD.delegate = self;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.finishBlock = block;
    [connection start];
    _mytimer=[NSTimer scheduledTimerWithTimeInterval:6.0
                                              target:self
                                            selector:@selector(turnOffHUD)
                                            userInfo:nil
                                             repeats:NO];
}

#pragma mark - NSURLConntctionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _expectedLength = [response expectedContentLength];
    _currentLength = 0;
    _HUD.mode = MBProgressHUDModeDeterminate;
    [_mytimer setFireDate:[NSDate distantFuture]];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    _currentLength += [data length];
    _HUD.progress = _currentLength / (float)_expectedLength;
    [_mutdata appendData:data];
    _imageResult = _mutdata;

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    _HUD.mode = MBProgressHUDModeCustomView;
    [_HUD hide:YES afterDelay:0.5];
    
    //数据结果block回调
    self.finishBlock(_imageResult);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    _HUD.mode = MBProgressHUDModeCustomView;
    _HUD.labelText= @"网络中断";
    [_HUD hide:YES afterDelay:0.5];
}


#pragma mark -private methods
//关闭菊花
- (void)turnOffHUD{
    _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    _HUD.mode = MBProgressHUDModeCustomView;
    _HUD.labelText = @"请求失败";
    [_HUD hide:YES afterDelay:0.5];
  
}

//关闭定时器
- (void)stopTimmer {
    [_mytimer invalidate];
    _mytimer=nil;
}

@end
