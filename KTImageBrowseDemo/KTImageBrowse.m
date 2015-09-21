//
//  KTImageBrowse.m
//  KTImageBrowse
//
//  Created by KT on 15/9/18.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "KTImageBrowse.h"
#import "BrowseViewController.h"
#import "ImageData.h"

@interface KTImageBrowse ()

@end

@implementation KTImageBrowse

#pragma mark - 在父视图内初始化
+ (void)setupBrowseViewInTargetView:(UIView *)supperView
                           withLine:(NSInteger)line
                             andRow:(NSInteger)row {
    BrowseViewController *browseViewController = [[BrowseViewController alloc] init];
    [browseViewController initViweInSuperView:supperView withLine:line andRow:row];
}

#pragma mark - 只有缩略图URL
+ (void)setImageDataWithURL:(NSArray *)URLArry
          andPlaceholdImage:(UIImage *)placeholdImage {
    [ImageData shareModel].imageUrlList = URLArry;
    [ImageData shareModel].imageBigUrlList = URLArry;
    [ImageData shareModel].placeholdImage = placeholdImage;
}

#pragma mark - 缩略图，大图URL
+ (void)setImageDataWithURL:(NSArray *)URLArry
        andOriginPictureURL:(NSArray *)OriginPicURLArry
          andPlaceholdImage:(UIImage *)placeholdImage {
    [ImageData shareModel].imageUrlList = URLArry;
    [ImageData shareModel].imageBigUrlList = OriginPicURLArry;
    [ImageData shareModel].placeholdImage = placeholdImage;
}


@end
