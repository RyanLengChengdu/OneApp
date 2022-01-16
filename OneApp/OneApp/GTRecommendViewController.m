//
//  GTRecommendViewController.m
//  OneApp
//
//  Created by 冷锐鹏 on 2022/1/7.
//

#import "GTRecommendViewController.h"

@interface GTRecommendViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation GTRecommendViewController
- (instancetype)init{
    if(self = [super init]){
        self.tabBarItem.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x"];
        self.tabBarItem.selectedImage =[UIImage imageNamed:@"icon.bundle/page_selected@2x"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.delegate = self;
    //总的内容大小
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*5, self.view.bounds.size.height);
    scrollView.showsHorizontalScrollIndicator = YES;
    
    NSArray *colorArray = @[[UIColor redColor],[UIColor whiteColor],[UIColor blackColor],[UIColor blueColor],[UIColor orangeColor]];
    for(int i = 0;i<5;i++){
        [scrollView addSubview:({
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
            
            //添加一个小方框视图
            [view addSubview:({
                UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
                view1.backgroundColor = [UIColor orangeColor];
                UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClicked)];
                recognizer.delegate = self;
                [view addGestureRecognizer:recognizer];
                view1;
            })];
            
            view.backgroundColor = colorArray[i];
            view;
        })];
    }
    //翻页形式
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"didscroll-%@",@(scrollView.contentOffset.x));
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"begindragging");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"enddragging");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"BeginDecelerating");
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"EndDecelerating");
}

//第三个tabbar中的小方框点击事件
-(void)viewClicked{
    NSLog(@"点击了方框");
}

//delegate是否响应手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
@end
