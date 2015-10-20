//
//  KTDownloadPicViewController.h
//  KTImageBrowse
//
//  Created by KT on 15/9/18.
//  Copyright (c) 2015年 KT. All rights reserved.
// 图片数据下载容器

#import <UIKit/UIKit.h>

typedef void (^FinishBlick)(NSData *resultData);

@interface KTDownloadPicViewController : UIViewController
@property (nonatomic, copy) FinishBlick finishBlock;
/**
 *  不带菊花下载图片
 *
 *  @param urlString 图片URL
 *  @param block     finish block
 */
- (void)downloadPicWithURLSting:(NSString *)urlString
                    finishBlock:(FinishBlick)block;

/**
 *  带菊花下载图片
 *
 *  @param urlString 图片URL
 *  @param block     finish block
 */
- (void)downloadPicWithURLStingWithProgress:(NSString *)urlString
                                finishBlock:(FinishBlick)block;
@end

