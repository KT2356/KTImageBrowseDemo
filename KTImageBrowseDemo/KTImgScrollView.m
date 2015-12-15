
//
//  KTImgScrollView.m
//  Picturetest
//
//  Created by KT on 15-7-18.
//  Copyright (c) 2015年 KT. All rights reserved.
//
#import "KTImgScrollView.h"
#import "KTScrollViewController.h"
#import "Masonry.h"

@interface KTImgScrollView()<UIScrollViewDelegate>
{
    UIImageView *_imgView;
    CGRect _scaleOriginRect;/**<记录自己的位置*/
    CGSize _imgSize; /**<图片的大小*/
    CGRect _initRect;/**<缩放前大小*/
}

@end

@implementation KTImgScrollView

#pragma mark - life cycle
- (void)dealloc {
    _i_delegate = nil;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bouncesZoom = YES;
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.minimumZoomScale = 1.0;
        
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor clearColor];
        _imgView.clipsToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imgView];
        
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
        singleTapGesture.numberOfTapsRequired = 1;
        singleTapGesture.numberOfTouchesRequired  = 1;
        [self addGestureRecognizer:singleTapGesture];
        
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTapGesture.numberOfTapsRequired = 2;
        doubleTapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:doubleTapGesture];
        
        [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    }
    return self;
}


#pragma mark - private method
- (void) setContentWithFrame:(CGRect) rect {
    _imgView.frame = rect;
    _initRect = rect;
}

- (void) setAnimationRect {
    _imgView.frame = _scaleOriginRect;
}

- (void) rechangeInitRdct {
    self.zoomScale = 1.0;
    _imgView.frame = _initRect;
}

- (void) setImage:(UIImage *) image {
    if (image) {
        _imgView.image = image;
        _imgSize = image.size;
        
        //判断首先缩放的值
        float scaleX = self.frame.size.width/_imgSize.width;
        float scaleY = self.frame.size.height/_imgSize.height;
        
        //倍数小的，先到边缘
        
        if (scaleX > scaleY) {
            //Y方向先到边缘
            float imgViewWidth = _imgSize.width*scaleY;
            self.maximumZoomScale = self.frame.size.width/imgViewWidth;
            _scaleOriginRect = (CGRect){self.frame.size.width/2-imgViewWidth/2 ,0,imgViewWidth,self.frame.size.height};
        } else {
            //X先到边缘
            float imgViewHeight = _imgSize.height*scaleX;
            self.maximumZoomScale = self.frame.size.height/imgViewHeight;
            _scaleOriginRect = (CGRect){0,self.frame.size.height/2-imgViewHeight/2 ,self.frame.size.width+10,imgViewHeight};
        }
    }
}


#pragma mark - UIScrollViewDelegate
- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {

    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = _imgView.frame;
    CGSize contentSize = scrollView.contentSize;
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    
    // center horizontally
    if (imgFrame.size.width <= boundsSize.width) {
        centerPoint.x = boundsSize.width/2;
    }
    // center vertically
    if (imgFrame.size.height <= boundsSize.height) {
        centerPoint.y = boundsSize.height/2;
    }
    _imgView.center = centerPoint;
}


// single tapped
- (void)handleSingleTap:(UIGestureRecognizer *)sender {
    if ([self.i_delegate respondsToSelector:@selector(tapImageViewTappedWithObject:)]) {
        [self.i_delegate tapImageViewTappedWithObject:self];
    }
}

// double tapped
- (void)handleDoubleTap:(UIGestureRecognizer *)sender {
   
    if(self.zoomScale > 1.0){
        self.zoomScale  = 1.0;
        [self setZoomScale:1.0 animated:YES];
    }else{
        self.zoomScale  = 2.0;
        [self setZoomScale:2.0 animated:YES];
    }

}


@end
