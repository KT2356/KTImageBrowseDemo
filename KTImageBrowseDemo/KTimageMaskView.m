//
//  KTImageMaskView.m
//  KTImageBrowse
//
//  Created by KT on 15/9/18.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "KTImageMaskView.h"
#import "Masonry.h"
#import "KTImageData.h"
@interface KTImageMaskView ()

@end

@implementation KTImageMaskView

#pragma mark - life cycle
- (void)dealloc {
    _maskViewDelegate = nil;
}
/**
 *  父视图内初始化
 *
 *  @param supperView 目标父视图
 *
 *  @return self
 */
- (instancetype)initWithView:(UIView *)supperView {
    [self setupScrollPanelViewInSuperView:supperView];
    [self setupMarkView];
    [self setupScrollView];
    
    [self setupCountLabelView];
    [self setupSaveButtonView];
    [self setupOriginPictureView];
    return self;
}

#pragma mark - private methods
/**
 *  初始化Panel
 *
 *  @param supperView 目标父视图
 */
- (void)setupScrollPanelViewInSuperView:(UIView *)supperView {
    _scrollPanel = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];//过渡layer
    _scrollPanel.backgroundColor = [UIColor clearColor];
    _scrollPanel.alpha = 0.0;
    [supperView addSubview:_scrollPanel];
    [_scrollPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(supperView.mas_top);
        make.left.equalTo(supperView.mas_left);
        make.right.equalTo(supperView.mas_right);
        make.bottom.equalTo(supperView.mas_bottom);
    }];
}

/**
 *  初始化黑色背景蒙板
 */
- (void)setupMarkView {
    _markView = [[UIView alloc] initWithFrame:_scrollPanel.bounds];//大图背景layer
    _markView.backgroundColor = [UIColor blackColor];
    _markView.alpha = 0.0;
    [_scrollPanel addSubview:_markView];
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollPanel.mas_top);
        make.left.equalTo(_scrollPanel.mas_left);
        make.right.equalTo(_scrollPanel.mas_right);
        make.bottom.equalTo(_scrollPanel.mas_bottom);
    }];
}

/**
 *  初始化图片计数器
 */
- (void)setupCountLabelView {
    _countLabel=[[UILabel alloc] init];
    _countLabel.backgroundColor=[UIColor clearColor];
    _countLabel.textColor=[UIColor whiteColor];
    _countLabel.font=[UIFont boldSystemFontOfSize:17];
    _countLabel.textAlignment = NSTextAlignmentCenter;

    [_scrollPanel addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 20));
        make.centerX.mas_equalTo(_scrollPanel.mas_centerX);
        make.top.equalTo(_scrollPanel.mas_top).with.offset(40);
    }];
}

/**
 *  初始化滚动视图
 */
- (void)setupScrollView {
    _scrollView = [[UIScrollView alloc]//左右屏幕滑动layer
                   initWithFrame:CGRectMake(0,
                                            0,
                                            [UIScreen mainScreen].bounds.size.width+15,
                                            [UIScreen mainScreen].bounds.size.height)];
    [_scrollPanel addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    CGSize contentSize = _scrollView.contentSize;
    contentSize.height =0;
    contentSize.width = ([UIScreen mainScreen].bounds.size.width + 15) * [KTImageData shareModel].imageUrlList.count ;
    _scrollView.contentSize = contentSize;
}

/**
 *  初始化保存图片按钮
 */
- (void)setupSaveButtonView {
    _mySaveButton=[UIButton buttonWithType:UIButtonTypeSystem];//图片保存到本地相册
    _mySaveButton.backgroundColor=[UIColor clearColor];
    [_mySaveButton.layer setCornerRadius:2.0];
    [_mySaveButton.layer setBorderWidth:0.2]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 255, 255, 255, 1 });
    [_mySaveButton.layer setBorderColor:colorref];//边框颜色
    [_mySaveButton setTitle:@"保存" forState:UIControlStateNormal];
    [_mySaveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _mySaveButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [_mySaveButton addTarget:self action:@selector(savePictureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollPanel addSubview:_mySaveButton];
    [_mySaveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 25));
        make.left.equalTo(_scrollPanel.mas_left).with.offset(20);
        make.bottom.equalTo(_scrollPanel.mas_bottom).with.offset(-20);
    }];
}

/**
 *  初始化原图按钮
 */
- (void)setupOriginPictureView {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 255, 255, 255, 1 });
    _myOriginPicture=[UIButton buttonWithType:UIButtonTypeSystem];//下载原图
    _myOriginPicture.frame=CGRectMake(80,_scrollPanel.bounds.size.height-45,40,25);
    _myOriginPicture.backgroundColor=[UIColor clearColor];
    [_myOriginPicture.layer setCornerRadius:2.0];
    [_myOriginPicture.layer setBorderWidth:0.2]; //边框宽度
    [_myOriginPicture.layer setBorderColor:colorref];//边框颜色
    [_myOriginPicture setTitle:@"原图" forState:UIControlStateNormal];
    [_myOriginPicture setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _myOriginPicture.titleLabel.font=[UIFont systemFontOfSize:12];
     [_myOriginPicture addTarget:self action:@selector(originPictureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollPanel addSubview:_myOriginPicture];
    [_myOriginPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 25));
        make.left.equalTo(_scrollPanel.mas_left).with.offset(80);
        make.bottom.equalTo(_scrollPanel.mas_bottom).with.offset(-20);
    }];
    
}

#pragma mark - action response
- (void)savePictureButtonClick {
    [self.maskViewDelegate saveButtonDidClicked];
}

- (void)originPictureButtonClick {
    [self.maskViewDelegate originPicButtonDidClicked];
}



@end
