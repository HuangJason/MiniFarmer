//
//  AskScrollView.m
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/13.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AskScrollView.h"
#import "ZoomScrollView.h"

@interface AskScrollView ()

///当前选中的selectedindex
@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation AskScrollView

- (instancetype)initWithFrame:(CGRect)frame
                       images:(NSMutableArray *)images
                selectedIndex:(NSInteger)selectedIndex
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor blackColor]];
        //创建小得scrollview根据数组的个数
        self.selectedIndex = selectedIndex;
        NSMutableArray *newImages = [[NSMutableArray alloc] initWithArray:images];
        [self reloadDataWihtInfos:[self newImagesWithImages:newImages]];
        self.pagingEnabled = YES;
        self.contentSize = CGSizeMake(kScreenSizeWidth *images.count, 60);
        self.contentOffset = CGPointMake(kScreenSizeWidth * selectedIndex, 0);
        [self addGesture];
    }
    return self;
}

- (void)addGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

- (void)reloadDataWihtInfos:(NSMutableArray *)infos
{
    CGFloat dwidth = CGRectGetWidth(self.frame);
    CGFloat dheigth = 200;
    for (int i = 0; i<infos.count; i++)
    {
        ZoomScrollView *zoom = [[ZoomScrollView alloc] initWithFrame:CGRectMake(dwidth * i,(CGRectGetHeight(self.frame) - dheigth)/2, dwidth, dheigth)];
        [zoom setBackgroundColor:[UIColor redColor]];
        MTPickerInfo *info = [infos objectAtIndex:i];
        [zoom setImage:info.image];
        [self addSubview:zoom];
    }
}

- (NSMutableArray *)newImagesWithImages:(NSMutableArray *)infos
{
    MTPickerInfo *info = [infos lastObject];
    if (info.isSelectImage)
    {
        [infos removeObject:info];
    }
    return infos;
}

//自身带有缩放功能的scrollview
- (ZoomScrollView *)zoomScrollview
{
    ZoomScrollView *scrollview = [[ZoomScrollView alloc] initWithFrame:CGRectZero];
//    [scrollview setBackgroundColor:[UIColor redColor]];
    return scrollview;
}

#pragma mark - tap
- (void)tap:(UITapGestureRecognizer *)tap
{
    [self dismiss];
}

- (void)show
{
    self.hidden = NO;
    [self.superview bringSubviewToFront:self];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

@end
