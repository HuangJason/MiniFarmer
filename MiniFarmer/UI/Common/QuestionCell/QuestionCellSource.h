//
//  QuestionCellSource.h
//  MiniFarmer
//
//  Created by huangjiancheng on 15/10/25.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionInfo.h"


#define kLeftSpace  12
#define kRightSpace  12
#define kMaxContentWidth (kScreenSizeWidth-kLeftSpace-kRightSpace)
#define kMaxContentLabelHeight 20000
#define kContentImgWidth  ((kMaxContentWidth-6)/3.0)
#define kContentImgHeight (kContentImgWidth/1.1)
#define kBottemViewHeight   36
#define kMiddleViewHeight   26

@interface QuestionCellSource : NSObject

@property (nonatomic,retain)QuestionInfo *qInfo;
@property (nonatomic,assign,readonly)CGSize contentLabelSize;
@property (nonatomic,assign,readonly)CGFloat cellTotalHeight;
@property (nonatomic,assign,readonly)CGFloat nameLabelWidth;
@property (nonatomic,assign,readonly)CGFloat locationLabelWidth;

- (instancetype)initWithQuestionInfo:(QuestionInfo *)info;
@end
