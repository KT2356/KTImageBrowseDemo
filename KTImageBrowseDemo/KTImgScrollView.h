
//
//  KTImgScrollView.h
//  Picturetest
//
//  Created by KT on 15-7-18.
//  Copyright (c) 2015年 KT. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol KTImgScrollViewDelegate <NSObject>
- (void) tapImageViewTappedWithObject:(id) sender;
@end


@interface KTImgScrollView : UIScrollView
@property (nonatomic, weak) id<KTImgScrollViewDelegate> i_delegate;

- (void) setContentWithFrame:(CGRect) rect;
- (void) setImage:(UIImage *) image;
- (void) setAnimationRect;
- (void) rechangeInitRdct;

@end
