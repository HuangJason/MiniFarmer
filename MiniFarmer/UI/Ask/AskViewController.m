//
//  AskViewController.m
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/6.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "AskViewController.h"
#import "BaseViewController+Navigation.h"
#import "GCPlaceholderTextView.h"
#import "AskCropNameView.h"
#import "AskSendModel.h"
#import "XDPhotoSelect.h"
#import "RootTabBarViewController.h"
#import "MTAssetsPickerController.h"
#import "MTPickerInfo.h"
#import "ImagesView.h"
#import "AskScrollView.h"

#define kPlaceHolderText @"请描述作物的异常情况和您的问题, 越详细专家越好给您准确的回答哟! (必填)"
#define kCountOfNumber 3
#define kImagesCount 6

@interface AskViewController ()<XDPhotoSelectDelegate,MTAssetsPickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,ImagesViewDelegate>

@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) GCPlaceholderTextView *askTextView;
@property (nonatomic, strong) GCPlaceholderTextView *nameTextView;
@property (nonatomic, strong) UIScrollView *askScrollview;
@property (nonatomic, strong) AskCropNameView *askCropNameView;
@property (nonatomic, strong) UIButton *addImageButton;
@property (nonatomic, strong) XDPhotoSelect *photoSelect;
//显示图片的view
@property (nonatomic, strong) ImagesView *imagesView;

/// 存放的对象是 MTPickerInfo 类型
@property (nonatomic, strong) NSMutableArray *arrayPhotos;
@end

@implementation AskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.arrayPhotos = [NSMutableArray array];
    self.photoSelect = [[XDPhotoSelect alloc] initWithController:self delegate:self];
    [self setStatusBarColor:[UIColor colorWithHexString:@"f8f8f8"]];
    [self setBarLeftDefualtButtonWithTarget:self action:@selector(dismissAskVC:)];
    [self setBarTitle:@"我的问题"];
    [self setLineToBarBottomWithColor:[UIColor colorWithHexString:@"a3a3a3"] heigth:kLineWidth];
    [self addSubviews];
    [self addGesture];
    
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarIsHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setNavigationBarIsHidden:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - event
- (void)dismissAskVC:(UIButton *)btn
{
    [self changeSelectedVC:0];
}

- (void)sendAsk:(UIButton *)btn
{
    //判断问题描述是否为空
    if (!self.askTextView.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"问题描述不能为空"];
        return;
    }
    else if (!self.askCropNameView.text.length)
    {
        [self.view showWeakPromptViewWithMessage:@"作物名称不能为空"];
        return;
    }
    NSDictionary *dic = @{@"c":@"tw",@"m":@"savetw",@"userid":[APPHelper safeString:[[MiniAppEngine shareMiniAppEngine] userId]],@"mobile":[APPHelper safeString:[[MiniAppEngine shareMiniAppEngine] userLoginNumber]],@"zjid":@"",@"wtzw":self.askCropNameView.text,@"wtms":self.askTextView.text};
    [[SHHttpClient defaultClient] requestWithMethod:SHHttpRequestPost parameters:dic prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        AskSendModel *sendModel = [[AskSendModel alloc] initWithDictionary:(NSDictionary *)responseObject error:nil];
        if ([sendModel.msg isEqualToString:@"success"])
        {
            [self.view showWeakPromptViewWithMessage:@"发送成功"];
            [self dismissAskVC:nil];
        }
        else
        {
            [self.view showWeakPromptViewWithMessage:@"发送失败"];
 
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.view showWeakPromptViewWithMessage:@"发送失败"];

    }];
}


- (void)addImages:(UIButton *)btn
{
}

#pragma mark - 选择照片后的回调
//选择完成后的回调
- (void)photoSelect:(XDPhotoSelect *)photoSelect didFinishedWithImageArray:(NSArray *)imageArray
{
    
}

//照片选择取消后的回调
- (void)photoSelectDidCancelled:(XDPhotoSelect *)photoSelect
{
    
}

#pragma mark -
- (void)mt_AssetsPickerController:(MTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.arrayPhotos removeAllObjects];
        
        for (ALAsset *asset in assets) {
            MTPickerInfo *pictureInfo =[MTPickerInfo new];
            pictureInfo.image =[UIImage imageWithCGImage:asset.thumbnail];
            pictureInfo.photoType = album;
            [pictureInfo bind:asset];
            [self.arrayPhotos insertObject:pictureInfo atIndex:0];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //TODO: 更新UI
            //显示图片
            [self reloadImagesView];

        });
    });
    
}


#pragma mark - subviews
- (void)addSubviews
{
    [self.view addSubview:self.askScrollview];
    [self.view addSubview:self.sendButton];
    [self.askScrollview addSubview:self.askTextView];
    [self.askScrollview addSubview:self.askCropNameView];
    [self.askScrollview addSubview:self.imagesView];
    
    
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight + 8);
        make.size.mas_equalTo(CGSizeMake(56, 28));
    }];
    
    CGRect subRect = self.view.bounds;
    subRect.origin.y = kStatusBarHeight + kNavigationBarHeight + kLineWidth;
    subRect.size.height -= kBottomTabBarHeight + kStatusBarHeight + kNavigationBarHeight + kLineWidth;
    [self.askScrollview setFrame:subRect];
    
    subRect.origin.x = 12;
    subRect.origin.y = 12 ;
    subRect.size.width = kScreenSizeWidth - 2 * 12;
    subRect.size.height = 160;
    self.askTextView.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.askTextView.frame);
    subRect.size.width = kScreenSizeWidth - 12;
    subRect.size.height = 48;
    self.askCropNameView.frame = subRect;
    
    subRect.origin.y = CGRectGetMaxY(self.askCropNameView.frame) + 18;
    subRect.size.width = kScreenSizeWidth - 2 * 12;
    self.imagesView.frame = subRect;
    
    
    [self reloadImagesView];
    
    
}

- (ImagesView *)imagesView
{
    if (!_imagesView)
    {
        _imagesView = [[ImagesView alloc] initWithFrame:CGRectZero];
        _imagesView.delegate = self;
    }
    return _imagesView;
}

- (UIScrollView *)askScrollview
{
    if (!_askScrollview)
    {
        _askScrollview = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _askScrollview.showsHorizontalScrollIndicator = NO;
    }
    return _askScrollview;
}

- (UIButton *)sendButton
{
    if (!_sendButton)
    {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_no_enable_nm"] forState:UIControlStateDisabled];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_hl"] forState:UIControlStateHighlighted];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"ask_send_btn_enable_nm"] forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_sendButton setEnabled:NO];
        [_sendButton addTarget:self action:@selector(sendAsk:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (UITextView *)askTextView
{
    if (!_askTextView)
    {
        _askTextView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectZero];
        _askTextView.textColor = [UIColor colorWithHexString:@"a3a3a3"];
        _askTextView.font = kTextFont(14);
        _askTextView.placeholderColor = _askTextView.textColor;
        _askTextView.delegate = self;
        _askTextView.placeholder = kPlaceHolderText;
        
    }
    return _askTextView;
}

- (AskCropNameView *)askCropNameView
{
    if (!_askCropNameView)
    {
        _askCropNameView = [[AskCropNameView alloc] initWithFrame:CGRectZero];
    }
    return _askCropNameView;
}

- (UIButton *)addImageButton
{
    if (!_addImageButton)
    {
        _addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageButton setBackgroundImage:[UIImage imageNamed:@"asd_btn_addimage"] forState:UIControlStateNormal];
        [_addImageButton addTarget:self action:@selector(addImages:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageButton;
}

#pragma mark - textdelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ((!textView.text.length
         || [textView.text isEqualToString:@""]))
    {
        [self changeSendButtonStateToEnable:NO];
    }

}

- (void)textViewDidChange:(UITextView *)textView
{
    if ((textView.text.length
         || ![textView.text isEqualToString:@""])
        && !self.sendButton.enabled)
    {
        [self changeSendButtonStateToEnable:YES];
    }
    
    if ((!textView.text.length
         || [textView.text isEqualToString:@""]) && self.sendButton.enabled)
    {
        [self changeSendButtonStateToEnable:NO];
    }
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ((!textView.text.length
         || [textView.text isEqualToString:@""]))
    {
        [self changeSendButtonStateToEnable:NO];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - imagesViewDelegate
- (void)imagesView:(ImagesView *)imagesView selectedItem:(NSInteger)selectedItem
{
    MTPickerInfo *info = [self.arrayPhotos objectAtIndex:selectedItem];
    if (info.isSelectImage)
    {
        //添加图片 进入相册进行选择
        //    [self.photoSelect startPhotoSelect:XDPhotoSelectFromLibrary];
        
        /// 另一套逻辑 mTime
        MTAssetsPickerController *picker = [[MTAssetsPickerController alloc] init];
        picker.assetsFilter = [ALAssetsFilter allPhotos];
        picker.delegate = self;
        [MTAssetsPickerController selections:self.arrayPhotos withMaximNum:6];
        [self presentViewController:picker animated:YES completion:nil];
 
    }
    else
    {
        //做别的处理 进入轮播啊 这样的
        AskScrollView *askScrollview = [[AskScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight) images:self.arrayPhotos selectedIndex:selectedItem];
        [self.view addSubview:askScrollview];
    }

}

#pragma mark - other
- (void)changeSelectedVC:(NSInteger)selectedIndex
{
    [self.navigationController.tabBarController setSelectedIndex:selectedIndex];
    [(RootTabBarViewController *)(self.navigationController.tabBarController) changeIndexToSelected:selectedIndex];
}

- (void)changeSendButtonStateToEnable:(BOOL)enable
{
    [self.sendButton setEnabled:enable];
}

- (NSMutableArray *)imagesArr
{
    if (self.arrayPhotos.count < kImagesCount)
    {
        MTPickerInfo *pictureInfo = [MTPickerInfo new];
        pictureInfo.isSelectImage = YES;
        pictureInfo.image = [UIImage imageNamed:@"asd_btn_addimage"];
        [self.arrayPhotos addObject:pictureInfo];
    }
    return self.arrayPhotos;
}

- (void)reloadImagesView
{
    [self.imagesView reloadDataWithImagesInfo:[self imagesArr]];
    self.askScrollview.contentSize = CGSizeMake(kScreenSizeWidth, CGRectGetMaxY(self.imagesView.frame) + kBottomTabBarHeight);
}

@end
