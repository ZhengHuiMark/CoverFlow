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
    
    // 4.设置内边距
    CGFloat inset = (self.collectionView.bounds.size.width - itemW) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    

    
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
        
        // - 5.旋转
        // - 5.1 旋转的角度!
        CGFloat angle = (1 - scale) * M_PI_2;
        
        // 如果距离大于0,左边 -> * 1,正的角度
        // 如果距离小于0,右边 -> * -1,负的角度!
        angle *= ((distance > 0) ? 1 : -1);

        // - 单位矩阵
        CATransform3D transform = CATransform3DIdentity;
        
        // - 5.3 增加透视效果
        transform.m34 = - 1.0 / 500;

        
        // - 4.2 缩放
        transform = CATransform3DScale(transform, scale, scale, 1);
        
        // - 5.2 旋转
        transform = CATransform3DRotate(transform, angle, 0, 1, 0);

        
        // 4.3 赋值!
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

#pragma mark - 计算停留的位置
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    // 1.获取系统计算好的值
    CGPoint point = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
    // 2.计算屏幕可见区域 -> CGRect!
    CGRect rect;
    rect.size = self.collectionView.bounds.size;
#warning - 预计停留的位置时,内容的偏移量!
    rect.origin = proposedContentOffset;
    
    // 3.获取可见区域内的cell!
#warning - 利用上面的方法,计算可见区域内的cell!
    NSArray<UICollectionViewLayoutAttributes *> *visibleAttrs = [self layoutAttributesForElementsInRect:rect];
    
    // 4.需要找出其中最近的cell!
    // 4.2 遍历,找出距离屏幕中线最近的cell对应的attr
    // - 屏幕中线的x
    CGFloat screenCenterX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    // - 定义一个最小的间距
    __block CGFloat minMargin = CGFLOAT_MAX;
    // - 定义一个索引,用来记录最近那个attr的在数组中!索引!
    __block NSInteger index = -1;
    
    [visibleAttrs enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat distance = screenCenterX - obj.center.x;
        
        if (ABS(distance) < minMargin) {
            minMargin = ABS(distance);
            index = idx;
        }
        
    }];
    
    // 5.计算需要偏移的距离!
    CGFloat offsetX = screenCenterX - visibleAttrs[index].center.x;
    
    // 2.返回点坐标
    return CGPointMake(point.x - offsetX, point.y);
}




@end
