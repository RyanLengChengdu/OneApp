//
//  GTDeleteCellView.h
//  OneApp
//
//  Created by 冷锐鹏 on 2022/1/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 删除cell确认浮层
@interface GTDeleteCellView : UIView

/// 点击出现删除cell的确认浮层
/// @param point （点击的位置）从哪个点开始动画
/// @param clickBlock 点击后的业务逻辑
-(void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock;
@end

NS_ASSUME_NONNULL_END
