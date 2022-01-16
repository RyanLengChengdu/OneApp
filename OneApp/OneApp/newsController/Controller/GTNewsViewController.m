//
//  ViewController.m
//  OneApp
//
//  Created by 冷锐鹏 on 2022/1/6.
//

#import "GTNewsViewController.h"
#import "GTNormalTableViewCell.h"
#import "GTDetailViewController.h"
#import "GTDeleteCellView.h"
#import "GTListLoader.h"
#import "GTListItem.h"

@interface GTNewsViewController ()<UITableViewDataSource,UITableViewDelegate,GTNormalTableViewCellDelegate>
@property(nonatomic,strong,readwrite)UITableView *tableView;
//删除指定cell后，会导致设定的cell数量和删除后的数量不相等，会产生crash，应当将数据放进数组
@property(nonatomic,strong,readwrite)NSArray *dataArray;
//
@property(nonatomic,strong,readwrite)GTListLoader *listLoader;
@end

@implementation GTNewsViewController
//初始化init
- (instancetype)init{
    if (self = [super init]) {
        self.tabBarItem.title = @"新闻";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x"];
        self.tabBarItem.selectedImage =[UIImage imageNamed:@"icon.bundle/page_selected@2x"];
    }
    return self;
}
#pragma mark - life cycle
//4个生命周期的函数
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

//最主要的函数
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //UITableView
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    self.listLoader = [[GTListLoader alloc]init];
    //处理循环引用问题
    __weak typeof(self) weakself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<GTListItem *> *dataArray) {
        __strong typeof(self)strongself = weakself;
        strongself.dataArray = dataArray;
        [strongself.tableView reloadData];
    }];
    
    
    
//    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor redColor];
//    view.frame = CGRectMake(100, 100, 100, 100);
//    [self.view addSubview:view];
    
//    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushController)];
//    [view addGestureRecognizer:recognizer];
}

#pragma mark - UITablwViewDataSource相关方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //复用回收机制，在创建cell之前先去复用回收池中看有无创建了的cell
    GTNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if(!cell){
        //然后使用if判断，如果复用回收池没有cell，那么就新创建一个cell。
        cell = [[GTNormalTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        cell.delegate = self;
    }
    
    [cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
    
    
    //系统默认的cell的style
//    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
//    cell.textLabel.text = [NSString stringWithFormat:@"主标题----%@",@(indexPath.row)];
//    cell.detailTextLabel.text = @"伏笔啊普通粉丝发顺丰";
//    cell.imageView.image = [UIImage imageNamed:@"icon.bundle/video@2x"];
    
}

- (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    UIViewController *controller = [[UIViewController alloc]init];
    controller.view.backgroundColor = [UIColor whiteColor];
    controller.title = [NSString stringWithFormat:@"%@",@(indexPath.row+1)];
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GTListItem *item = [self.dataArray objectAtIndex:indexPath.row];
    GTDetailViewController *controller = [[GTDetailViewController alloc]initWithURLString:item.articleURL];
    controller.view.backgroundColor = [UIColor whiteColor];
    controller.title = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    [self.navigationController pushViewController:controller animated:YES];
}


//自建的cell的delegate需要实现的方法     将tableViewCell和deleteButton传到了ViewController
-(void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton{
//    GTDeleteCellView *deleteview = [[GTDeleteCellView alloc]initWithFrame:self.view.bounds];
//
//    //需要转换point到整个window的坐标系，因为参数button的frame是以cell为参照物的
//   CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
//
//    //处理循环引用问题
//    __weak typeof(self) weakself = self;
//    //点击deletecellview 调用block删除cell
//    [deleteview showDeleteViewFromPoint:CGPointMake(rect.origin.x, rect.origin.y) clickBlock:^{
//        //block作用：删除cell
//        __strong typeof(self)strongself = weakself;
//        //[strongself.dataArray removeLastObject];
//        //在此处增加删除cell的逻辑
//        [strongself.tableView deleteRowsAtIndexPaths:@[[strongself.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
//
//    }];
}
//-(void)pushController{
//    UIViewController *viewController = [[UIViewController alloc]init];
//    viewController.view.backgroundColor = [UIColor whiteColor];
//    viewController.navigationItem.title = @"标题";
//    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"右侧标题" style:UIBarButtonItemStylePlain target:self action:nil];
//    [self.navigationController pushViewController:viewController animated:YES];
//}
@end
