//
//  KTImageModel.m
//  KTImageBrowse
//
//  Created by KT on 15/9/18.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "KTImageModel.h"
@interface KTImageModel()

@end

@implementation KTImageModel


//自定义模型转换
- (id) initWithCoder: (NSCoder *)coder {
    if (self = [super init]) {
        _isSavedInAlbum = [coder decodeObjectForKey:@"isSavedInAlbum"];
        _isOriginPicture = [coder decodeObjectForKey:@"isOriginPicture"];
        _imageIdentifier = [coder decodeObjectForKey:@"imageIdentifier"];
    }
    return self;
}

//自定义模型转换
- (void) encodeWithCoder: (NSCoder *)coder {
    [coder encodeObject:_isSavedInAlbum forKey:@"isSavedInAlbum"];
    [coder encodeObject:_isOriginPicture forKey:@"isOriginPicture"];
    [coder encodeObject:_imageIdentifier forKey:@"imageIdentifier"];
}

@end

