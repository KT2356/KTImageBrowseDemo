//
//  KTImageModel.h
//  KTImageBrowse
//
//  Created by KT on 15/9/18.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTImageModel : NSObject

@property (nonatomic, strong) NSString *isSavedInAlbum;/**< 是否保存于相册 */
@property (nonatomic, strong) NSString *isOriginPicture;/**< 是否已经是原图  */
@property (nonatomic, strong) NSString *imageIdentifier;/**< 图像identifier */


@end
