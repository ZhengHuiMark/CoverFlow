//
//  ViewController.m
//  CoverFlow
//
//  Created by app on 16/10/29.
//  Copyright © 2016年 ZHMARK. All rights reserved.
//

#import "ViewController.h"
#import "ZHCoverFlowCell.h"
#import "ZHCoverFlowLayout.h"
// 重用标识符
static NSString *cellId = @"cellID";

@interface ViewController () <UICollectionViewDataSource>

@end

@implementation ViewController {
    
    /**
     *  用来保存,3张美图图片!
     */
    NSArray<UIImage *> *_imgsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
}

#pragma mark - 数据源方法
// 返回item的个数!
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

// 返回cell!
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建cell
    ZHCoverFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    // 2.设置数据
//    cell.backgroundColor = [UIColor redColor];
    cell.image = _imgsArr[indexPath.row % 3];

  
    // 3.返回cell
    return cell;
}



#pragma mark - 加载数据
- (void)loadData {
    
    _imgsArr = @[
                 [UIImage imageNamed:@"01"],
                 [UIImage imageNamed:@"02"],
                 [UIImage imageNamed:@"03"],
                 ];
}

#pragma mark - 搭建界面
- (void)setupUI {
    
    // MARK: - 1.添加collectionView
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    ZHCoverFlowLayout *flowLayout = [[ZHCoverFlowLayout alloc]init];
    
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) collectionViewLayout:flowLayout];
   
    cv.backgroundColor = [UIColor lightGrayColor];
    
    // 设置数据源对象
    cv.dataSource = self;
    
    // 注册cell
    
    [cv registerClass:[ZHCoverFlowCell class] forCellWithReuseIdentifier:cellId];
   
    [self.view addSubview:cv];
    
}




@end
