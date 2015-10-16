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

#pragma mark - 在父视图内初始化
+ (void)setupBrowseViewInTargetView:(UIView *)supperView
                           withLine:(NSInteger)line
                             andRow:(NSInteger)row {
    KTBrowseViewController *browseViewController = [[KTBrowseViewController alloc] init];
    [browseViewController initViweInSuperView:supperView withLine:line andRow:row];
}

#pragma mark - 只有缩略图URL
+ (void)setImageDataWithURL:(NSArray *)URLArry
          andPlaceholdImage:(UIImage *)placeholdImage {
    [KTImageData shareModel].imageUrlList = URLArry;
    [KTImageData shareModel].imageBigUrlList = URLArry;
    [KTImageData shareModel].placeholdImage = placeholdImage;
}

#pragma mark - 缩略图，大图URL
+ (void)setImageDataWithURL:(NSArray *)URLArry
        andOriginPictureURL:(NSArray *)OriginPicURLArry
          andPlaceholdImage:(UIImage *)placeholdImage {
    [KTImageData shareModel].imageUrlList = URLArry;
    [KTImageData shareModel].imageBigUrlList = OriginPicURLArry;
    [KTImageData shareModel].placeholdImage = placeholdImage;
}


@end
