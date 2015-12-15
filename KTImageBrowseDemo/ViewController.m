//
//  ViewController.m
//  KTImageBrowseDemo
//
//  Created by KT on 15/9/21.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "ViewController.h"
#import "KTImageBrowse.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    UIView *tempview = [[UIView alloc] initWithFrame:CGRectMake(0, 50,240, 400)];
    tempview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tempview];
    
    NSArray *imageURL = @[@"http://img2.3lian.com/img2007/19/33/005.jpg",
                          @"http://pica.nipic.com/2008-03-19/2008319183523380_2.jpg",
                          @"http://pic2.ooopic.com/01/03/51/25b1OOOPIC19.jpg",
                          @"http://pic1.ooopic.com/uploadfilepic/sheji/2009-05-05/OOOPIC_vip4_20090505079ae095187332ea.jpg",
                          @"http://zx.kaitao.cn/UserFiles/Image/beijingtupian6.jpg",
                          @"http://imgk.zol.com.cn/dcbbs/2342/a2341460.jpg",
                          @"http://pic1.ooopic.com/uploadfilepic/sheji/2010-01-13/OOOPIC_1982zpwang407_20100113f68118f451f282f4.jpg",
                          @"http://news.51sheyuan.com/uploads/allimg/111001/133442IB-2.jpg"];
    
    NSArray *bigimageURL = @[@"http://img.xiaba.cvimage.cn/4cc027077b693a527e440300.jpg",
                             @"http://img.xiaba.cvimage.cn/4d7dc1ffd1869f34787a2d00.jpg",
                             @"http://pic16.nipic.com/20110907/6927608_141519677000_2.png",
                             @"http://img.xiaba.cvimage.cn/4cc0270a414fba537e380300.jpg",
                             @"http://www.icosky.com/icon/png/System/QuickPix%202007/Shamrock.png",
                             @"http://f6.topit.me/6/78/4f/114450727612e4f786l.jpg",
                             @"http://img.sc115.com/uploads/png/110125/20110125140509853.png",
                             @"http://img.xiaba.cvimage.cn/4ec75b93e568837461003660.jpg"];
    
    UIImage *placeholderImage = [UIImage imageNamed:@"appIcon60.png"];
    
    
    [KTImageBrowse setImageDataWithURL:imageURL
                   andOriginPictureURL:bigimageURL
                     andPlaceholdImage:placeholderImage];
    
    
    [KTImageBrowse setupBrowseViewInTargetView:tempview
                                      withLine:4
                                        andRow:4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
