//
//  PictureModel.h
//  WaterFile
//
//  Created by MS on 15/8/23.
//  Copyright (c) 2015年 zhanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureModel : NSObject
@property(nonatomic,copy)NSString*contentid;
@property(nonatomic,copy)NSString*modelid;
@property(nonatomic,copy)NSString*title;
@property(nonatomic,copy)NSString*thumb;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
//@property(nonatomic,copy)NSString*description;
@property(nonatomic,copy)NSString*comments;
@property(nonatomic,copy)NSString*sorttime;

@end
