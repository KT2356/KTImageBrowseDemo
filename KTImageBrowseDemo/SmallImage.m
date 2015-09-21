//
//  SmallImage.m
//  KTImageBrowse
//
//  Created by KT on 15/9/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "SmallImage.h"
#import "Masonry.h"
#import "ImageData.h"


@interface SmallImage()
@property (nonatomic, strong) UIView *tempView;
@end

@implementation SmallImage

#pragma mark - life cycle
- (void)dealloc {
    _ktSmallImageDelegate = nil;
}

- (instancetype)initInSupperView:(UIView *)supperView withWidth:(float) width{
    self = [super init];
    if (self) {
        _tempView = [[UIView alloc] init];
        _tempView = supperView;
        [supperView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(width);
        }];
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        UITapGestureRecognizer *imageTapped = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(imageTapped:)];
        [self addGestureRecognizer:imageTapped];
       
    }
    return self;
}

#pragma mark - Action response
- (void)imageTapped:(UITapGestureRecognizer *)gesture {
    if ([self.ktSmallImageDelegate respondsToSelector:@selector(smallImageTapped:)]) {
        [self.ktSmallImageDelegate smallImageTapped:(SmallImage *)[_tempView viewWithTag:self.tag]];
    }
}

@end
