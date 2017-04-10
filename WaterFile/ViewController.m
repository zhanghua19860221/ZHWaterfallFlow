//
//  ViewController.m
//  WaterFile
//
//  Created by MS on 15/8/23.
//  Copyright (c) 2015年 zhanghua. All rights reserved.
//

#import "ViewController.h"
#import "CustomWaterFlowLayout.h"
#import "HttpRequestBlock.h"
#import "PictureModel.h"
#import "PictureCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#define PICTUREURL @"http://api.newslu.cn/mobile/index.php?app=mobile&controller=picture&action=index&page=%d&time=0&classifyid="
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,CustomWaterFlowLayoutDelegate>
{
    
    NSMutableArray*_dataArray;
    int page;
}
@end
@implementation ViewController

////懒加载
//-(NSMutableArray*)dataArray
//{
//    if (_dataArray==nil) {
//        _dataArray=[[NSMutableArray alloc]init];
//    }
//    return _dataArray;
//}

static NSString*const ID=@"picture";

- (void)viewDidLoad {
    [super viewDidLoad];
    page=1;
    [self  loadData];
   
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)loadData
{
    
    _dataArray=[[NSMutableArray alloc]init];
    
    HttpRequestBlock*request=[[HttpRequestBlock alloc]initWithUrlStr:[NSString stringWithFormat:PICTUREURL,page] Block:^(HttpRequestBlock *http, BOOL isSucceed) {
        NSArray*array=http.dataDic[@"data"];
        for (NSDictionary*dic in array) {
            PictureModel*model=[[PictureModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [self  createCollectionView];
    }];
   

}
-(void)createCollectionView
{
    
    CustomWaterFlowLayout *layout = [[CustomWaterFlowLayout alloc] init];
    layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    layout.delegate = self;
    
    // 2.创建UICollectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];

    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    [_collectionView registerNib:[UINib nibWithNibName:@"PictureCell"  bundle:nil]forCellWithReuseIdentifier:ID];
    [self.view addSubview:_collectionView];

    // 3.增加刷新控件
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreShops)];

}
-(void)loadMoreShops
{
    
    page++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadData];
        [self.collectionView reloadData];
        [self.collectionView footerEndRefreshing];
    });
    

}
#pragma mark - <HMWaterflowLayoutDelegate>

- (CGFloat)waterflowLayout:(CustomWaterFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    PictureModel *model = _dataArray[indexPath.item];
    return model.height / model.width * width;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PictureCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    PictureModel*model=_dataArray[indexPath.row];
    
    [cell addSourceTocell:model];
    
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
