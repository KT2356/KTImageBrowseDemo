//
//  KTBrowseViewController.m
//  KTImageBrowse
//
//  Created by KT on 15/9/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "KTBrowseViewController.h"
#import "KTSmallImage.h"
#import "Masonry.h"
#import "KTImageData.h"
#import "KTScrollViewController.h"
#import "KTDownloadPicViewController.h"
@interface KTBrowseViewController()<KTSmallImageDelegate>

@property (nonatomic, assign) NSInteger imageLine;
@property (nonatomic, assign) NSInteger imageRow;
@property (nonatomic, assign) float imageWidth;
@property (nonatomic, strong) KTScrollViewController *scrollViewController;

@end
@implementation KTBrowseViewController

#pragma mark - public methods
- (void)initViweInSuperView:(UIView *)supperView
                   withLine:(NSInteger)line
                     andRow:(NSInteger)row
{
    _imageLine = line;
    [KTImageData shareModel].imageLine = line;
    _imageRow = row;
    _imageWidth = (supperView.frame.size.width - 5*2 - 5*(_imageLine - 1) )/_imageLine;
    
    [self setupBrowseViewInView:supperView];
    [self fixFirstRowPositiomInView:supperView];
    [self fixOtherRowInView:supperView];
}


#pragma mark - private methods
//缩略图矩阵排列
- (void)setupBrowseViewInView:(UIView *) supperView {
    NSInteger index = 0;
    for (int i = 0; i < _imageRow; i++) {
        for (int j = 0; j <_imageLine; j++) {
            
            KTSmallImage *smallImage = [[KTSmallImage alloc] initInSupperView:supperView withWidth:_imageWidth];
            smallImage.ktSmallImageDelegate = self;
            smallImage.image = [KTImageData shareModel].placeholdImage;
            
            //tag统一加10 因为0不能成为tag
            NSInteger tag = [NSString stringWithFormat:@"%d%d",i,j].intValue + 10;
            smallImage.tag = tag;
            
            if ([KTImageData shareModel].imageUrlList.count) {
                NSString *imageStr = [KTImageData shareModel].imageUrlList[index];
                if (imageStr) {
                        NSString *savedImagePath = [KTImageData getSaveImagePathWithCurrentIndex:index];
                        NSData *myd=[NSData dataWithContentsOfFile:savedImagePath];
                    
                        //如果缓存内没有数据则进行网络请求
                        if (!myd) {
                                KTDownloadPicViewController * dn = [[KTDownloadPicViewController alloc] init];
                                [dn downloadPicWithURLSting: [KTImageData shareModel].imageUrlList[index]
                                                            finishBlock:^(NSData *resultData) {
                                                                smallImage.image = [UIImage imageWithData:resultData];
                                                                [resultData writeToFile:savedImagePath atomically:YES];
                                                            }];
                        } else {
                            smallImage.image = [UIImage imageWithData:myd];
                        }
                }
                index ++;
                if (index == [KTImageData shareModel].imageUrlList.count ) {
                    return;
                }
            }
            
        }
    }
}

// 固定第一行image位置
- (void)fixFirstRowPositiomInView:(UIView *)supperView {
    UIView *tempView;
    //第一排 top固定
    for (int i = 0; i < _imageLine; i++) {
        tempView = [supperView viewWithTag:i+10];
        [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(supperView.mas_top).with.offset(5);
        }];
    }
    //第一排 中间左右间距固定
    for (int i = 1; i < _imageLine - 1; i++) {
        tempView = [supperView viewWithTag:i+10];
        [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo([supperView viewWithTag:i+10-1].mas_right).with.offset(5);
        }];
    }
    //第一排 左边第一个
    tempView = [supperView viewWithTag:10];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(supperView.mas_left).with.offset(5);
    }];
    //第一排 右边第一个
    tempView = [supperView viewWithTag:_imageLine+10 -1];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(supperView.mas_right).with.offset(-5);
    }];
}

//依据第一行位置确定其他行
- (void)fixOtherRowInView:(UIView *)supperView {
    UIView *tempView;
    for (int i = 1; i < _imageRow; i++) {
        for (int j = 0; j < _imageLine ; j++) {
            tempView = [supperView viewWithTag:i*10 +10 +j];
            [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo([supperView viewWithTag:i*10+j].mas_centerX);
                make.top.equalTo([supperView viewWithTag:i*10+j].mas_bottom).with.offset(5);
            }];
        }
    }
}


#pragma mark - ktSmallImageDelegate
- (void)smallImageTapped:(KTSmallImage *)image {
    [self.scrollViewController tapKTSmallImage:image];
}



#pragma mark - setter/getter
- (KTScrollViewController *)scrollViewController {
    if (!_scrollViewController) {
        _scrollViewController = [[KTScrollViewController alloc] init];
    }
    return _scrollViewController;
}

@end
