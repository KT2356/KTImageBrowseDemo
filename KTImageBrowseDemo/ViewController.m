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
    
    NSArray *imageURL = @[@"http://z.k1982.com/png/up/200712/20071208032102209.png",
                          @"http://img.ph.126.net/YAKpG99LlvQW9XEuuwI3OQ==/3281716753471215299.png",
                          @"http://img.xiaba.cvimage.cn/4cc023186403702b44060200.jpg",
                          @"http://img.xiaba.cvimage.cn/4cc026d4f047664e7e900200.jpg",
                          @"http://img.cool80.com/i/png/191/03.png",
                          @"http://img.xiaba.cvimage.cn/4cc026d41d2954527e800200.jpg",
                          @"http://img.xiaba.cvimage.cn/4cc026d48d9008557e3c0200.jpg",
                          @"http://img.xiaba.cvimage.cn/4f3f2dfae290c56646000640.jpg"];
    
    NSArray *bigimageURL = @[@"http://img.xiaba.cvimage.cn/4cc027077b693a527e440300.jpg",
                             @"http://img.xiaba.cvimage.cn/4d7dc1ffd1869f34787a2d00.jpg",
                             @"http://pic16.nipic.com/20110907/6927608_141519677000_2.png",
                             @"http://img.xiaba.cvimage.cn/4cc0270a414fba537e380300.jpg",
                             @"http://www.icosky.com/icon/png/System/QuickPix%202007/Shamrock.png",
                             @"http://f6.topit.me/6/78/4f/114450727612e4f786l.jpg",
                             @"http://img.sc115.com/uploads/png/110125/20110125140509853.png",
                             @"http://img.xiaba.cvimage.cn/4ec75b93e568837461003660.jpg"];
    
    UIImage *placeholderImage = [UIImage imageNamed:@"appicon60.png"];
    
    
    [KTImageBrowse setImageDataWithURL:imageURL
                   andOriginPictureURL:bigimageURL
                     andPlaceholdImage:placeholderImage];
    
    
    [KTImageBrowse setupBrowseViewInTargetView:tempview
                                      withLine:3
                                        andRow:3];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
