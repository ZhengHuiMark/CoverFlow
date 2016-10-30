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
        
//        newAttr.transform3D = CATransform3DRotate(newAttr.transform3D, M_PI_4, 0, 1, 0);
        // 2.2.2 修改属性! -> 缩放 & 旋转!
        // MARK: - 1.缩放
        // - 1.屏幕中线的位置
        CGFloat screenCenterX = self.collectionView.bounds.size.width * 0.5 + self.collectionView.contentOffset.x;
        
        // - 2.每个cell的中心的x!!
        CGFloat itemCenterX = newAttr.center.x;
        
        // - 3.计算距离
        CGFloat distance = screenCenterX - itemCenterX;
        
        // - 4.将距离转换成缩放的比例! ABS() -> 取绝对值!
        CGFloat scale = 1 - ABS(distance) / self.collectionView.bounds.size.width;
        
        // - 单位矩阵
        CATransform3D transform = CATransform3DIdentity;
        
        
        // - 缩放
        transform = CATransform3DScale(transform, scale, scale, 1);
        
        // 赋值!
        newAttr.transform3D = transform;

        // 2.2.x 保存到临时集合
        [tempArrM addObject:newAttr];
    }];
    
    // 3.返回
    return tempArrM;

}

#pragma mark - 只要显示的区域发生变化,就重新计算布局!
// Invalidate 失效! 返回YES! 只要显示的区域发生改变,就让布局失效!
// 重新计算布局!
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}



@end
