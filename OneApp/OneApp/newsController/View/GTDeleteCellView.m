//
//  GTDeleteCellView.m
//  OneApp
//
//  Created by 冷锐鹏 on 2022/1/10.
//

#import "GTDeleteCellView.h"

@interface GTDeleteCellView ()
@property(nonatomic,strong,readwrite)UIView *backgroundView;
@property(nonatomic,strong,readwrite)UIButton *deleteButton;
@property(nonatomic,copy,readwrite)dispatch_block_t deleteBlock;
@end
@implementation GTDeleteCellView
//必须先将新视图对象插入到窗口的视图层次结构中，然后才能使用它。如果以编程方式创建视图对象，则此方法是 UIView 类的指定初始值设定项。子类可以重写此方法以执行任何自定义初始化，但必须在实现开始时调用 super

- (instancetype)initWithFrame:(CGRect)frame
{
    //子类可以重写此方法以执行任何自定义初始化，但必须在实现开始时调用 super
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
                    self.backgroundView = [[UIView alloc]initWithFrame:self.bounds];
                    self.backgroundView.backgroundColor = [UIColor blackColor];
                    self.backgroundView.alpha = 0.5;
            [self.backgroundView addGestureRecognizer:({
                UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissDeleteView)];
                gesture;
            })];
                    self.backgroundView;
                })];
        
        [self addSubview:({
                    self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
                    [self.deleteButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
                    self.deleteButton.backgroundColor = [UIColor redColor];
                    self.deleteButton.titleLabel.text = @"title";
                    self.deleteButton;
                })];
    }
    return self;
}
//这个新建的cellView什么时候出现 什么时候隐藏 需要实现show和dismiss方法
    //通过Block，在GTDeleteCellView和ViewController中去传递是哪一个按钮的点击
-(void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock{
    
    //设置deleteButton的起始frame初始值
    self.deleteButton.frame = CGRectMake(point.x, point.y, 0, 0);
    
    //当点击的时候持有该block   此句让这个deleteCellView拥有block的属性，才能在最下方clickButton方法内执行从ViewController传递过来的block
    self.deleteBlock = [clickBlock copy];
    
    //让新出现的View不影响下面的viewController
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    //UIView的动画方法都是类方法，所以需要用UIView来调用
    [UIView animateWithDuration:1.f animations:^{
        
        //使用与物理弹簧运动相对应的时序曲线执行视图动画。
        [UIView animateWithDuration:1.f delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.deleteButton.frame = CGRectMake((self.bounds.size.width-200)/2, (self.bounds.size.height-200)/2, 200, 200);
        } completion:^(BOOL finished) {
            NSLog(@"动画完成");
        }];
    }];
}
-(void)dismissDeleteView{
    [self removeFromSuperview];
}
-(void)clickButton{
    //当点击deleteButton之后执行block
    if(self.deleteBlock){
        self.deleteBlock();
    }
    [self removeFromSuperview];
}
@end
