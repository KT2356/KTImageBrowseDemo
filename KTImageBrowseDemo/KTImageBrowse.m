//
//  KTImageBrowse.m
//  KTImageBrowse
//
//  Created by KT on 15/9/18.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "KTImageBrowse.h"
#import "KTBrowseViewController.h"
#import "KTImageData.h"

@interface KTImageBrowse ()

@end

@implementation KTImageBrowse

/**
 *  在父视图内初始化
 *
 *  @param supperView 目标父视图
 *  @param line       缩略图显示列数
 *  @param row        缩略图显示行数
 */
+ (void)setupBrowseViewInTargetView:(UIView *)supperView
                           withLine:(NSInteger)line
                             andRow:(NSInteger)row {
    KTBrowseViewController *browseViewController = [[KTBrowseViewController alloc] init];
    [browseViewController initViweInSuperView:supperView withLine:line andRow:row];
}

/**
 *  只有缩略图URL
 *
 *  @param URLArry        小图URL
 *  @param placeholdImage 默认图片
 */
+ (void)setImageDataWithURL:(NSArray *)URLArry
          andPlaceholdImage:(UIImage *)placeholdImage {
    [KTImageData shareModel].imageUrlList = URLArry;
    [KTImageData shareModel].imageBigUrlList = URLArry;
    [KTImageData shareModel].placeholdImage = placeholdImage;
}

/**
 *  缩略图，大图URL
 *
 *  @param URLArry          小图URL
 *  @param OriginPicURLArry 大图URL
 *  @param placeholdImage   默认图片
 */
+ (void)setImageDataWithURL:(NSArray *)URLArry
        andOriginPictureURL:(NSArray *)OriginPicURLArry
          andPlaceholdImage:(UIImage *)placeholdImage {
    [KTImageData shareModel].imageUrlList = URLArry;
    [KTImageData shareModel].imageBigUrlList = OriginPicURLArry;
    [KTImageData shareModel].placeholdImage = placeholdImage;
}


@end
