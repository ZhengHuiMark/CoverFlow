//
//  ZHCoverFlowLayout.m
//  CoverFlow
//
//  Created by app on 16/10/30.
//  Copyright © 2016年 ZHMARK. All rights reserved.
//

#import "ZHCoverFlowLayout.h"

@implementation ZHCoverFlowLayout

- (void)prepareLayout {
    
    [super prepareLayout];
    
    // 1.调整滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 2.设置大小
    CGFloat itemH = self.collectionView.bounds.size.height * 0.8;
    CGFloat itemW = itemH;
    
    self.itemSize = CGSizeMake(itemW, itemH);
    
    // 3.设置间距
    self.minimumLineSpacing = 0;
    
}

@end
