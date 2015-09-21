//
//  ScrollViewController.m
//  KTImageBrowse
//
//  Created by KT on 15/9/15.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "ScrollViewController.h"
#import "ImageData.h"
#import "SmallImage.h"
#import "ImgScrollView.h"
#import "MaskView.h"
#import "ImageModel.h"
#import "MBProgressHUD.h"
#import "DownloadPicViewController.h"

@interface ScrollViewController()<UIScrollViewDelegate,ImgScrollViewDelegate,MaskViewDelegate>
{
    NSInteger _imageCount;
    NSInteger _currentIndex;
}

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) UIView *scrollPanel;
@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *originPictureButton;
@property (nonatomic, strong) UIButton *savePictureButton;
@property (nonatomic, assign)  CGRect convertRectView;
@property (nonatomic, strong) MaskView *setMaskView;

@property (nonatomic, strong) UIView *supperViewTemp;

@end

@implementation ScrollViewController

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _imageCount = [ImageData shareModel].imageUrlList.count;
        _rootViewController = [[UIViewController alloc] init];
        _rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        _setMaskView = [[MaskView alloc] initWithView:_rootViewController.view];
        _setMaskView.maskViewDelegate = self;
        
        _scrollPanel = _setMaskView.scrollPanel;
        _markView = _setMaskView.markView;
        _countLabel = _setMaskView.countLabel;
        _scrollView = _setMaskView.scrollView;
        _originPictureButton = _setMaskView.myOriginPicture;
        _savePictureButton = _setMaskView.mySaveButton;
        _scrollView.delegate = self;
    }
    return self;
}


#pragma mark - public methods
- (void) tapSmallImage:(SmallImage *)sender {
    _supperViewTemp = sender.superview;
    [self.view bringSubviewToFront:_scrollView];
    _scrollPanel.alpha = 1.0;
    
    SmallImage *tmpView = sender;
    _currentIndex = [ImageData tagToIndex:tmpView.tag];
    NSString *labelOutString=[[NSString alloc] initWithFormat:@"%ld/%ld",(long)(_currentIndex+1),(long)_imageCount];
    _countLabel.text=labelOutString;
    [self checkButtonStateWithCurrentIndex:_currentIndex];

    CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:_rootViewController.view];
    CGPoint contentOffset = _scrollView.contentOffset;
    contentOffset.x = _currentIndex*([UIScreen mainScreen].bounds.size.width );
    _scrollView.contentOffset = contentOffset;
    
    [self addSubImgView:sender];
    ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){contentOffset,_scrollView.bounds.size}];
    [tmpImgScrollView setContentWithFrame:convertRect];
    tmpImgScrollView.i_delegate = self;
    
    
    [tmpImgScrollView setImage:tmpView.image];
    [_scrollView addSubview:tmpImgScrollView];
    
    [self performSelector:@selector(setOriginFrame:) withObject:tmpImgScrollView afterDelay:0];
}



#pragma mark -  ImgScrollViewDelegate
- (void) tapImageViewTappedWithObject:(id)sender
{
    ImgScrollView *tmpImgView = sender;
    [UIView animateWithDuration:0.5 animations:^{
        _markView.alpha = 0;
        [tmpImgView rechangeInitRdct];
    } completion:^(BOOL finished) {
        _scrollPanel.alpha = 0;
    }];
}

#pragma mark - ScrollViewDelegate
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    _currentIndex = floor((scrollView.contentOffset.x - pageWidth-10 / 2) / pageWidth) + 2;
    NSString *outstring=[[NSString alloc] initWithFormat:@"%ld/%ld",(long)(_currentIndex+1),(long)_imageCount];
    _countLabel.text=outstring;
    
    [self checkButtonStateWithCurrentIndex:_currentIndex];
    
}


#pragma mark - MaskViewDelegate
//保存相册按钮单击
- (void)saveButtonDidClicked {
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *readImagePath=[documentsDirectory stringByAppendingPathComponent:
                             [[ImageData shareModel].imageUrlList[_currentIndex] stringByReplacingOccurrencesOfString:@"/" withString:@""]];
    NSData *myDataFromPath=[NSData dataWithContentsOfFile:readImagePath];
    UIImage *savedImage=[UIImage imageWithData:myDataFromPath];
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

//原图按钮单击
- (void)originPicButtonDidClicked {
    __block NSData *data;
    DownloadPicViewController * dn = [[DownloadPicViewController alloc] init];
    __weak typeof(self) weakself = self;
    NSString *savedImagePath = [ImageData getSaveImagePathWithCurrentIndex:_currentIndex];
    [dn downloadPicWithURLStingWithProgress: [ImageData shareModel].imageBigUrlList[_currentIndex]
                                finishBlock:^(NSData *resultData) {
                                    data = resultData;
                                    [weakself waitForDownloadWithData:data];
                                    [data writeToFile:savedImagePath atomically:YES];
                                    _originPictureButton.hidden = YES;
                                }];
    
    ImageModel *imageModel = [ImageData getImageModelWithIdentifier:[[ImageData shareModel].imageUrlList[_currentIndex] stringByReplacingOccurrencesOfString:@"/" withString:@""]];
    if (!imageModel) {
        imageModel = [[ImageModel alloc] init];
        imageModel.imageIdentifier = [[ImageData shareModel].imageUrlList[_currentIndex] stringByReplacingOccurrencesOfString:@"/" withString:@""];
    }
    imageModel.isOriginPicture = @"YES";
    
    [ImageData  storeImageModel:imageModel];
}

#pragma mark - ImageSaveing Delegate
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil;
    if(error) {
        msg = @"保存图片失败";
    } else {
        msg = @"保存图片成功";
        _savePictureButton.hidden = YES;
        ImageModel *imageModel = [ImageData getImageModelWithIdentifier:[[ImageData shareModel].imageUrlList[_currentIndex] stringByReplacingOccurrencesOfString:@"/" withString:@""]];
        if (!imageModel) {
            imageModel = [[ImageModel alloc] init];
            imageModel.imageIdentifier = [[ImageData shareModel].imageUrlList[_currentIndex] stringByReplacingOccurrencesOfString:@"/" withString:@""];
        }
        imageModel.isSavedInAlbum = @"YES";
        
        [ImageData  storeImageModel:imageModel];
    }
    MBProgressHUD *HUD;
    HUD = [MBProgressHUD showHUDAddedTo:_rootViewController.view animated:YES];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText=msg;
    [HUD hide:YES afterDelay:0.5];
}

#pragma mark - private methods
- (void) addSubImgView:(SmallImage *)sender {
    for (UIView *tmpView in _scrollView.subviews) {
        [tmpView removeFromSuperview];
    }
    
    for (int i = 0; i < _imageCount; i ++) {
        if (i == _currentIndex) {//单击当前位置不创建图片
            continue;
        }
        
        SmallImage *tmpView = (SmallImage *)[[sender superview]
                                             viewWithTag:[ImageData indexToTag:i]];
        
        _convertRectView = [[tmpView superview] convertRect:tmpView.frame toView:_rootViewController.view];
        ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:
                                           (CGRect){i*([UIScreen mainScreen].bounds.size.width ),0,_scrollView.bounds.size}];
        
        [tmpImgScrollView setContentWithFrame:_convertRectView];
        [tmpImgScrollView setImage:tmpView.image];
        [_scrollView addSubview:tmpImgScrollView];
        
        tmpImgScrollView.i_delegate = self;
        [tmpImgScrollView setAnimationRect];
    }
}


//大图弹出动画效果
- (void) setOriginFrame:(ImgScrollView *) sender
{
    [UIView animateWithDuration:0.5 animations:^{
        [sender setAnimationRect];
        _markView.alpha = 1.0;
    }];
}

- (void)checkButtonStateWithCurrentIndex:(NSInteger)currentIndex {
    ImageModel *imageModel = [ImageData getImageModelWithIdentifier:[[ImageData shareModel].imageUrlList[currentIndex] stringByReplacingOccurrencesOfString:@"/" withString:@""]];
    if (imageModel) {
        if ([imageModel.isOriginPicture isEqualToString:@"YES"]) {
            _originPictureButton.hidden = YES;
        }
        else {
            _originPictureButton.hidden = NO;
        }
        
        if ([imageModel.isSavedInAlbum isEqualToString:@"YES"]) {
            _savePictureButton.hidden = YES;
        }
        else {
            _savePictureButton.hidden = NO;
        }
        
    }
    else {
            _originPictureButton.hidden = NO;
            _savePictureButton.hidden = NO;
    }
}

- (void)waitForDownloadWithData:(NSData *)data {
    
    NSInteger tag= [ImageData indexToTag:_currentIndex];
    SmallImage *tmpView = (SmallImage *)[_supperViewTemp viewWithTag:tag];
    tmpView.image = [UIImage imageWithData:data];
    [self addSubImgView:tmpView];
    
    _convertRectView = [[tmpView superview] convertRect:tmpView.frame toView:_rootViewController.view];
    ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:
                                       (CGRect){_currentIndex*_scrollView.bounds.size.width,0,_scrollView.bounds.size}];
    
    [tmpImgScrollView setContentWithFrame:_convertRectView];
    
    UIImage *bigimage=[UIImage imageWithData:data ];
    [tmpImgScrollView setImage:bigimage];
    
    [_scrollView addSubview:tmpImgScrollView];
    tmpImgScrollView.i_delegate = self;
    [tmpImgScrollView setAnimationRect];

    
}
@end
