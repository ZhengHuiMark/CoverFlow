//
//  ZHCoverFlowCell.m
//  CoverFlow
//
//  Created by app on 16/10/29.
//  Copyright © 2016年 ZHMARK. All rights reserved.
//

#import "ZHCoverFlowCell.h"


@interface ZHCoverFlowCell ()

/**
 *  用于显示图片的图片框
 */
@property (weak, nonatomic) UIImageView *imgView;

@end

@implementation ZHCoverFlowCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置数据
- (void)setImage:(UIImage *)image {
    
    _image = image;
    
    _imgView.image = image;
    
}

#pragma mark - 搭建界面
- (void)setupUI {
    
    // MARK: - 1.添加imageView
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bounds];
    imgView.backgroundColor = [UIColor magentaColor];
    // 设置图片的填充模式!
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    
    // 设置圆角
    imgView.layer.cornerRadius = 10;
    imgView.layer.masksToBounds = YES;
    
    // 设置边框颜色
    imgView.layer.borderColor = [UIColor whiteColor].CGColor;
    imgView.layer.borderWidth = 1;

    
    [self.contentView addSubview:imgView];
    
    // 记录成员变量
    _imgView = imgView;

}




@end
