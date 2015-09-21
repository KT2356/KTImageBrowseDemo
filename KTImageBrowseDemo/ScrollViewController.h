//
//  ScrollViewController.h
//  KTImageBrowse
//
//  Created by KT on 15/9/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//  图片滑动控制器

#import <UIKit/UIKit.h>
@class SmallImage;

@interface ScrollViewController : UIViewController

- (void) tapSmallImage:(SmallImage *)sender;
@end
