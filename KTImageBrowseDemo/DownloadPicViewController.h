//
//  DownloadPicViewController.h
//  KTImageBrowse
//
//  Created by KT on 15/9/18.
//  Copyright (c) 2015年 KT. All rights reserved.
// 图片数据下载容器

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

typedef void (^FinishBlick)(NSData *resultData);

@interface DownloadPicViewController : UIViewController
@property (nonatomic, copy) FinishBlick finishBlock;

- (void)downloadPicWithURLSting:(NSString *)urlString
                    finishBlock:(FinishBlick)block;


- (void)downloadPicWithURLStingWithProgress:(NSString *)urlString
                                finishBlock:(FinishBlick)block;
@end

