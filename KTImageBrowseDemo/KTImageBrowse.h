//
//  KTImageBrowse.h
//  KTImageBrowse
//
//  Created by KT on 15/9/18.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTImageBrowse : UIViewController

+ (void)setupBrowseViewInTargetView:(UIView *)supperView
                           withLine:(NSInteger)line
                             andRow:(NSInteger)row;

+ (void)setImageDataWithURL:(NSArray *)URLArry
          andPlaceholdImage:(UIImage *)placeholdImage;

+ (void)setImageDataWithURL:(NSArray *)URLArry
        andOriginPictureURL:(NSArray *)OriginPicURLArry
          andPlaceholdImage:(UIImage *)placeholdImage;

@end
