//
//  BrowseViewController.h
//  KTImageBrowse
//
//  Created by KT on 15/9/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//  缩略图Autolayout 矩阵排列

#import <UIKit/UIKit.h>
@interface BrowseViewController : UIViewController

- (void)initViweInSuperView:(UIView *)superView
                   withLine:(NSInteger)line
                     andRow:(NSInteger)row;
@end
