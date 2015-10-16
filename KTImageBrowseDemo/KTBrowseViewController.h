//
//  KTBrowseViewController.h
//  KTImageBrowse
//
//  Created by KT on 15/9/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//  缩略图Autolayout 矩阵排列

#import <UIKit/UIKit.h>
@interface KTBrowseViewController : UIViewController
/**
 *  在父视图中初始化
 *
 *  @param superView 目标父视图
 *  @param line      显示缩略图列数
 *  @param row       显示缩略图行数
 */
- (void)initViweInSuperView:(UIView *)superView
                   withLine:(NSInteger)line
                     andRow:(NSInteger)row;
@end
