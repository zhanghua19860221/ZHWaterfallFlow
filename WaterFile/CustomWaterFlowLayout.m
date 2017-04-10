//
//  CustomWaterFlowLayout.m
//  WaterFile
//
//  Created by MS on 15/8/23.
//  Copyright (c) 2015年 zhanghua. All rights reserved.
//

#import "CustomWaterFlowLayout.h"

@interface CustomWaterFlowLayout ()

//这个字典存储每一列的最大Y值（每一列的高度）
@property(nonatomic,strong)NSMutableDictionary *maxYDict;

/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

@end

@implementation CustomWaterFlowLayout

//-(instancetype)init
//{
//    if (self=[super init]) {
//        self.maxYDict=[[NSMutableDictionary alloc]init];
//    }
//
//    return self;
//}
-(NSMutableDictionary *)maxYDict
{
    if (!_maxYDict) {
          self.maxYDict=[[NSMutableDictionary alloc]init];
    }
    return _maxYDict;
}
-(NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray=[[NSMutableArray alloc]init];
    }
    return _attrsArray;
}
-(instancetype)init
{
    if (self=[super init]) {
        self.SpaceHeg=10;
        self.SpaceWid=10;
        self.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
        self.showColCount=2;
       self.maxYDict=[[NSMutableDictionary alloc]init];
    }
    return self;
}
//每次布局之前的准备
-(void)prepareLayout
{
    [super prepareLayout];
    //1、清空最大的Y值
    for (int i=0; i<self.showColCount; i++) {
        NSString*column=[NSString stringWithFormat:@"%d",i];
        self.maxYDict[column]=@(self.sectionInset.top);
    }
    //2、计算所有的cell的属性
    [self.attrsArray removeAllObjects];
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<count; i++) {
        UICollectionViewLayoutAttributes*attrs=[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
//返回所有的尺寸
-(CGSize)collectionViewContentSize
{
    //假设最大的那一列 是第0列
    __block NSString*maxColumn=@"0";
    //找出最短的那一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString*column, NSNumber*maxY, BOOL *stop) {
        if ([maxY floatValue]>[self.maxYDict[maxColumn] floatValue] ) {
            maxColumn=column;
        }
    }];
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue]+self.sectionInset.bottom );
}
/**
 *  返回indexPath这个位置Item的布局属性
 */
-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self.maxYDict);
    //假设最小的那一列 是第0列
    __block NSString*minColumn=@"0";
    //找出最短的那一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString*column, NSNumber*maxY, BOOL *stop) {
        if ([maxY floatValue]<[self.maxYDict[minColumn] floatValue] ) {
            minColumn=column;
        }
    }];
    NSLog(@"%@",minColumn);
    
    //计算每个item的宽度
    CGFloat width=(self.collectionView.frame.size.width-self.sectionInset.left-self.sectionInset.right-(self.showColCount-1)*self.SpaceWid)/self.showColCount;
    //计算每个Item的高度
    CGFloat height=[self.delegate waterflowLayout:self heightForWidth:width atIndexPath:indexPath];
    
    //计算位置
    CGFloat x=self.sectionInset.left+(width+self.SpaceWid)*[minColumn intValue];
    CGFloat y= [self.maxYDict[minColumn] floatValue]+self.SpaceHeg ;
    //更新这一列的最大Y值
    self.maxYDict[minColumn]=@(y+height);
    
    //创建属性
    UICollectionViewLayoutAttributes*attrs=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attrs.frame=CGRectMake(x, y, width, height);
    
    return attrs;
}
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    
//    for (int i=0; i<self.showColCount; i++) {
//        NSString*column = [NSString stringWithFormat:@"%d",i];
//        self.maxYDict[column] = @0;
//    }
//    NSMutableArray*array=[NSMutableArray array];
//    NSInteger count=[self.collectionView  numberOfItemsInSection:0];
//    for (int i=0 ; i<count;i++) {
//        UICollectionViewLayoutAttributes*attrs=[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
//        
//        [array addObject:attrs];
//        
//    }
//    return array;
    
    return self.attrsArray;
}
@end
