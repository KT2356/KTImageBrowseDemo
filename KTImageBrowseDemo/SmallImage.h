//
//  SmallImage.h
//  KTImageBrowse
//
//  Created by KT on 15/9/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SmallImage;

@protocol SmallImageDelegate<NSObject>
@required
- (void)smallImageTapped:(SmallImage *)image;
@end


@interface SmallImage : UIImageView

@property(nonatomic, strong) id<SmallImageDelegate> ktSmallImageDelegate;
- (instancetype)initInSupperView:(UIView *)supperView withWidth:(float) width;

@end
