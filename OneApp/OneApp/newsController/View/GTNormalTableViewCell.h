//
//  GTNormalTableViewCell.h
//  OneApp
//
//  Created by 冷锐鹏 on 2022/1/7.
//

#import <UIKit/UIKit.h>
@class GTListItem;
NS_ASSUME_NONNULL_BEGIN
@protocol GTNormalTableViewCellDelegate <NSObject>

//要传递自己及自己view当中的元素，就需要在本类方法中声明，参数就是需要传递的内容
-(void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;

@end



@interface GTNormalTableViewCell : UITableViewCell
@property(nonatomic,weak,readwrite)id <GTNormalTableViewCellDelegate> delegate;
-(void)layoutTableViewCellWithItem:(GTListItem *)item;
@end

NS_ASSUME_NONNULL_END
