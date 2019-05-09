//
//  LZXViewController.m
//  引导页
//
//  Created by twzs on 16/6/23.
//  Copyright © 2016年 LZX. All rights reserved.
//

#import "LZXViewController.h"
#import "LZXCollectionViewCell.h"


@interface LZXViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *collectionV;
    NSMutableArray *marray;
    NSMutableArray *marrayURL;
}

@end

@implementation LZXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCollectionView];
  
        
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)addCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    // 设置cell 大小
    layout.itemSize = self.view.bounds.size;
    
    // 设置滑动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置间距
    layout.minimumLineSpacing = 0;
    
    collectionV = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collectionV.delegate = self;
    
    collectionV.dataSource = self;
    // 隐藏滚动条
    collectionV.showsHorizontalScrollIndicator = NO;
    
    // 设置分页效果
    collectionV.pagingEnabled = YES;
    
//    // 设置弹簧效果
//    collectionV.bounces =  NO;
    
    [self.view addSubview:collectionV];
    
    [collectionV registerClass:[LZXCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return marrayURL?marrayURL.count:self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LZXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.imageviewbg.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
    
    if (marray.count > indexPath.row) {
      [cell.imageviewbg sd_setImageWithURL:[NSURL URLWithString:marray[indexPath.row]]];
    }
    

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArray.count - 1) {
        
        [self judgeToSkip];
    }else{

    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    float contentNum = scrollView.contentOffset.x / ZJScreenWidth;
    if (contentNum > self.dataArray.count - 1) {
        [self judgeToSkip];
    }
}

-(void)judgeToSkip{
    UNSaveObject(@"Yes", @"firstlogin");
    [self backToHome];
}

@end
