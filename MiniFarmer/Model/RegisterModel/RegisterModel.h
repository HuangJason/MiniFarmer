//
//  RegisterModel.h
//  MiniFarmer
//
//  Created by 尹新春 on 15/11/8.
//  Copyright © 2015年 enbs. All rights reserved.
//

#import "JSONModel.h"

@interface RegisterModel : JSONModel

@property (nonatomic, strong) NSNumber<Optional> *code;
@property (nonatomic, copy) NSString<Optional> *msg;
@property (nonatomic, copy) NSString<Optional> *vcode;

@end
