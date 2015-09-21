//
//  ImageData.m
//  KTImageBrowse
//
//  Created by KT on 15/9/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "ImageData.h"
#import "ImageModel.h"

@implementation ImageData

//数据模型单例
+ (instancetype)shareModel {
    static ImageData *data;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [[ImageData alloc] init];
    });
    return data;
}

//获取图像保存路径
+ (NSString *)getSaveImagePathWithCurrentIndex:(NSInteger)currentIndex {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);//新图替换原图data
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:
                              [[ImageData shareModel].imageUrlList[currentIndex] stringByReplacingOccurrencesOfString:@"/" withString:@""]];
    return savedImagePath;
}

// 通过图像identifier获取图像Model
+ (ImageModel *)getImageModelWithIdentifier:(NSString *)identifer {
    ImageModel *imageModel;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:imageModel];
    udObject = [userDefault objectForKey:identifer];
    if (udObject) {
        imageModel = [NSKeyedUnarchiver unarchiveObjectWithData:udObject] ;
    }
    return imageModel;
}

///保存图像Model
+ (void)storeImageModel:(ImageModel *)imageModel {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:imageModel];
    if (udObject) {
        [userDefault setObject:udObject forKey:imageModel.imageIdentifier];
    }
}

//排列缩略图时采用矩阵类型，因此将index与tag进行转换
+ (NSInteger)indexToTag:(NSInteger)index {
    NSInteger tag = 0;
    if (index < [ImageData shareModel].imageLine) {
        tag = index + 10;
    } else {
        NSInteger mutlply = 0;
        mutlply = (index )/[ImageData shareModel].imageLine;
        tag = mutlply *10 + (index - [ImageData shareModel].imageLine * mutlply)+10;
    }
    return tag;
}

// tag转index
+ (NSInteger)tagToIndex:(NSInteger)tag {
    NSInteger index = 0;
    if (tag -10 <10) {
        index = tag - 10;
    } else {
        NSInteger mutlply = 0;
        mutlply = (tag -10)/10;
        index = mutlply*[ImageData shareModel].imageLine +tag -10*mutlply -10;
    }
    return index;
}

@end
