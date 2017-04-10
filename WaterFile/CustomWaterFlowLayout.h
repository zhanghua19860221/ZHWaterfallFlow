//
//  CustomWaterFlowLayout.h
//  WaterFile
//
//  Created by MS on 15/8/23.
//  Copyright (c) 2015年 zhanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomWaterFlowLayout;

@protocol CustomWaterFlowLayoutDelegate <NSObject>

- (CGFloat)waterflowLayout:(CustomWaterFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface CustomWaterFlowLayout : UICollectionViewLayout
//宽高间距
@property(nonatomic,assign)CGFloat SpaceWid;
@property(nonatomic,assign)CGFloat SpaceHeg;

//设置 屏幕四周的 距离
@property(nonatomic,assign)UIEdgeInsets sectionInset;
//self.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);

//显示多少列
@property(nonatomic,assign)int showColCount;


@property(nonatomic,weak)id<CustomWaterFlowLayoutDelegate> delegate;

@end
