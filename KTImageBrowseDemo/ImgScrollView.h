
//
//  ImgScrollView.h
//  Picturetest
//
//  Created by KT on 15-7-18.
//  Copyright (c) 2015年 KT. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol ImgScrollViewDelegate <NSObject>
- (void) tapImageViewTappedWithObject:(id) sender;
@end


@interface ImgScrollView : UIScrollView
@property (nonatomic, weak) id<ImgScrollViewDelegate> i_delegate;

- (void) setContentWithFrame:(CGRect) rect;
- (void) setImage:(UIImage *) image;
- (void) setAnimationRect;
- (void) rechangeInitRdct;

@end
