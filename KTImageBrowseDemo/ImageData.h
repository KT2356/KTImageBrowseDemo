//
//  ImageData.h
//  KTImageBrowse
//
//  Created by KT on 15/9/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ImageModel;
@interface ImageData : NSObject

@property (nonatomic, strong) NSArray *imageUrlList;/**<缩略图URL*/
@property (nonatomic, strong) NSArray *imageBigUrlList;/**<大图URL*/
@property (nonatomic, strong) UIImage *placeholdImage;/**<默认图*/
@property (nonatomic, assign) NSInteger imageLine;/**<显示图片行数*/


+ (instancetype)shareModel;
+ (NSInteger)indexToTag:(NSInteger)index;
+ (NSInteger)tagToIndex:(NSInteger)tag;

+ (ImageModel *)getImageModelWithIdentifier:(NSString *)identifer ;
+ (void)storeImageModel:(ImageModel *)imageModel ;
+ (NSString *)getSaveImagePathWithCurrentIndex:(NSInteger)currentIndex;
@end

