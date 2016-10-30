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

#pragma mark - 布局一定却与的cell
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    // 1.先获取系统布局好的结果!
    NSArray<UICollectionViewLayoutAttributes *> *oldAttrsArr = [super layoutAttributesForElementsInRect:rect];
    
    // 2.遍历集合,进行修改
    // 2.1 临时集合
    NSMutableArray *tempArrM = [NSMutableArray array];
    
    // 2.2 遍历集合,修改属性
    [oldAttrsArr enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 2.2.1 修改之前先copy!
        UICollectionViewLayoutAttributes *newAttr = obj.copy;
        
        newAttr.transform3D = CATransform3DRotate(newAttr.transform3D, M_PI_4, 0, 1, 0);
        
        // 2.2.x 保存到临时集合
        [tempArrM addObject:newAttr];
    }];
    
    // 3.返回
    return tempArrM;

}

@end
