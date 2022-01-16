//
//  GTNormalTableViewCell.m
//  OneApp
//
//  Created by 冷锐鹏 on 2022/1/7.
//

#import "GTNormalTableViewCell.h"
#import "GTListItem.h"
@interface GTNormalTableViewCell ()
@property(nonatomic,strong,readwrite)UILabel *titleLabel;
@property(nonatomic,strong,readwrite)UILabel *sourceLabel;
@property(nonatomic,strong,readwrite)UILabel *commentLabel;
@property(nonatomic,strong,readwrite)UILabel *timeLabel;
@property(nonatomic,strong,readwrite)UIImageView *rightImageView;
@property(nonatomic,strong,readwrite)UIButton *deleteButton;
@end

@implementation GTNormalTableViewCell
//重写初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self.contentView addSubview:({
            self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 270, 50)];
            self.titleLabel.numberOfLines = 2;
            self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            self.titleLabel.font = [UIFont systemFontOfSize:18];
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel;
        })];
        
        //加入图片
        [self.contentView addSubview:({
            self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(300, 15, 100, 70)];
            [self.rightImageView setContentMode:UIViewContentModeScaleAspectFill];
            self.rightImageView;
        })];
        
        //加入button
       /* [self.contentView addSubview:({
            self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(260, 50, 30, 30)];
            [self.deleteButton setTitle:@"X" forState:UIControlStateNormal];
            [self.deleteButton setTitle:@"☑️" forState:UIControlStateHighlighted];
            [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
            self.deleteButton.backgroundColor = [UIColor blueColor];
            
            //全部系统UI组件都可以取到对应的CALayer
            //设置删除按钮x的圆角
            self.deleteButton.layer.cornerRadius = 10;
            self.deleteButton.layer.masksToBounds = YES;
            
            //设置x的边框颜色    要用.CGColor转换
            self.deleteButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
            self.deleteButton.layer.borderWidth = 3;
            //shadow相关
            self.deleteButton.layer.shadowColor = [UIColor blackColor].CGColor;
            self.deleteButton.layer.shadowOpacity = 0.5;
            
            self.deleteButton;
        })];
        */
        
        
        [self.contentView addSubview:({
            self.sourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 50, 20)];
            self.sourceLabel.font = [UIFont systemFontOfSize:12];
            self.sourceLabel.textColor = [UIColor lightGrayColor];
            self.sourceLabel;
        })];
        
        [self.contentView addSubview:({
            self.commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 50, 20)];
            self.commentLabel.font = [UIFont systemFontOfSize:12];
            self.commentLabel.textColor = [UIColor lightGrayColor];
            self.commentLabel;
        })];
        
        [self.contentView addSubview:({
            self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 70, 50, 20)];
            self.timeLabel.font = [UIFont systemFontOfSize:12];
            self.timeLabel.textColor = [UIColor lightGrayColor];
            self.timeLabel;
        })];
    }
    return self;
}

-(void)layoutTableViewCellWithItem:(GTListItem *)item{
    self.titleLabel.text = item.title;
    self.sourceLabel.text =item.authorName;
    //sizeToFit自适应
    [self.sourceLabel sizeToFit];
    
    self.commentLabel.text = item.category;
    [self.commentLabel sizeToFit];
    self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width+30, self.commentLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);
    self.timeLabel.text = item.date;
    self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width+30, self.commentLabel.frame.origin.y, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);
    [self.timeLabel sizeToFit];
    
    //NSData加载图片
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picURL]]];
    self.rightImageView.image = image;
}


-(void)deleteButtonClick{
    //当点击deleteButton的时候，进行的操作
    //要通过代理传值，就需要先判断有无delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickDeleteButton:)]) {
        //相当于告诉viewController中的delegate是那哪一个cell 是哪一个Button
        [self.delegate tableViewCell:self clickDeleteButton:self.deleteButton];
    }
}
@end
