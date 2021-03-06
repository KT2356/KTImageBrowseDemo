//
//  KTImageData.m
//  KTImageBrowse
//
//  Created by KT on 15/9/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "KTImageData.h"
#import "KTImageModel.h"

@implementation KTImageData

/**
 *  数据模型单例
 *
 *  @return KTImageData
 */
+ (instancetype)shareModel {
    static KTImageData *data;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [[KTImageData alloc] init];
    });
    return data;
}

/**
 *  获取图像保存路径
 *
 *  @param currentIndex 图片序号
 *
 *  @return 图片保存路径
 */
+ (NSString *)getSaveImagePathWithCurrentIndex:(NSInteger)currentIndex {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);//新图替换原图data
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:
                              [[KTImageData shareModel].imageUrlList[currentIndex] stringByReplacingOccurrencesOfString:@"/" withString:@""]];
    return savedImagePath;
}

/**
 *   通过图像identifier获取图像Model
 *
 *  @param identifer 图片的 ID
 *
 *  @return KTImageModel
 */
+ (KTImageModel *)getImageModelWithIdentifier:(NSString *)identifer {
    KTImageModel *imageModel;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:imageModel];
    udObject = [userDefault objectForKey:identifer];
    if (udObject) {
        imageModel = [NSKeyedUnarchiver unarchiveObjectWithData:udObject] ;
    }
    return imageModel;
}

/**
 *  保存图像Model
 *
 *  @param imageModel 图像模型
 */
+ (void)storeImageModel:(KTImageModel *)imageModel {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:imageModel];
    if (udObject) {
        [userDefault setObject:udObject forKey:imageModel.imageIdentifier];
    }
}

/**
 *  排列缩略图时采用矩阵类型，因此将index与tag进行转换
 *
 *  @param index 图片序号
 *
 *  @return 图片tag
 */
+ (NSInteger)indexToTag:(NSInteger)index {
    NSInteger tag = 0;
    if (index < [KTImageData shareModel].imageLine) {
        tag = index + 10;
    } else {
        NSInteger mutlply = 0;
        mutlply = (index )/[KTImageData shareModel].imageLine;
        tag = mutlply *10 + (index - [KTImageData shareModel].imageLine * mutlply)+10;
    }
    return tag;
}

/**
 *  tag转index
 *
 *  @param tag 图片tag
 *
 *  @return 图片序号
 */
+ (NSInteger)tagToIndex:(NSInteger)tag {
    NSInteger index = 0;
    if (tag -10 <10) {
        index = tag - 10;
    } else {
        NSInteger mutlply = 0;
        mutlply = (tag -10)/10;
        index = mutlply*[KTImageData shareModel].imageLine +tag -10*mutlply -10;
    }
    return index;
}

@end
