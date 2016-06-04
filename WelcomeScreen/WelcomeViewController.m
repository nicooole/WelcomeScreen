//
//  WelcomeViewController.m
//  WelcomeScreen
//
//  Created by 南珂 on 16/6/4.
//  Copyright © 2016年 Nicole. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MainViewController.h"
@interface WelcomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpScrollView];
    [self setUpPageControl];
}
- (void)setUpScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(4 * scrollView.frame.size.width, scrollView.frame.size.height);
    
    for (NSInteger i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        NSString *imageName = [NSString stringWithFormat:@"welcome%ld", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        imageView.image = image;
        [scrollView addSubview:imageView];
        if (i == 3) {
            [self addEnterAppButton:imageView];
        }
    }
    
    
    [self.view addSubview:scrollView];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    
}
- (void)addEnterAppButton:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake((imageView.frame.size.width - 120) * 0.5, imageView.frame.size.height * 0.6, 120, 30);
    [button setTitle:@"点此进入" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [imageView addSubview:button];
    
    [button addTarget:self action:@selector(enterApp:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)enterApp:(UIButton *)button
{
    MainViewController *mainViewController = [[MainViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainViewController;
}
- (void)setUpPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.pageControl = pageControl;
    
    pageControl.frame = CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 40);
    [self.view addSubview:pageControl];
    pageControl.numberOfPages = 4;
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    pageControl.userInteractionEnabled = NO;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    self.pageControl.currentPage = round(point.x / scrollView.frame.size.width);
}
@end
