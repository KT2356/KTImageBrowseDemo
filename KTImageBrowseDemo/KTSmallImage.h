//
//  KTSmallImage.h
//  KTImageBrowse
//
//  Created by KT on 15/9/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KTSmallImage;

@protocol KTSmallImageDelegate <NSObject>
@required
- (void)smallImageTapped:(KTSmallImage *)image;
@end


@interface KTSmallImage : UIImageView

@property(nonatomic, strong) id<KTSmallImageDelegate> ktSmallImageDelegate;
- (instancetype)initInSupperView:(UIView *)supperView withWidth:(float) width;

@end
