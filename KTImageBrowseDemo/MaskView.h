//
//  MaskView.h
//  KTImageBrowse
//
//  Created by KT on 15/9/18.
//  Copyright (c) 2015年 KT. All rights reserved.
//
//
//小图单击后，对出现对大图进行基本视图初始化

#import <UIKit/UIKit.h>

@protocol MaskViewDelegate <NSObject>
@required 
- (void)saveButtonDidClicked;
- (void)originPicButtonDidClicked;
@end


@interface MaskView : UIView

@property (nonatomic, weak) id<MaskViewDelegate>maskViewDelegate;

@property (nonatomic, strong) UIView *scrollPanel;
@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *myOriginPicture;
@property (nonatomic, strong) UIButton *mySaveButton;

- (instancetype)initWithView:(UIView *)supperView;

@end
