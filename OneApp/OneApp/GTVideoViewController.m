//
//  GTVideoViewController.m
//  OneApp
//
//  Created by 冷锐鹏 on 2022/1/7.
//

#import "GTVideoViewController.h"

@interface GTVideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation GTVideoViewController
- (instancetype)init {
	if(self = [super init]) {
		self.view.backgroundColor = [UIColor blueColor];
		self.tabBarItem.title = @"视频";
		self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x"];
		self.tabBarItem.selectedImage =[UIImage imageNamed:@"icon.bundle/page_selected@2x"];
	}
	return self;
}
- (void)viewDidLoad {
	[super viewDidLoad];

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
	flowLayout.minimumLineSpacing = 10;
	flowLayout.minimumInteritemSpacing = 10;
	flowLayout.itemSize = CGSizeMake((self.view.frame.size.width-10)/2, 300);
	UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
	[collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
	collectionView.delegate = self;
	collectionView.dataSource = self;
	[self.view addSubview:collectionView];

}

//UICollectionViewDataSource需要实现的方法numberOfItemsInSection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 20;
}

//UICollectionViewDataSource需要实现的方法cellForItemAtIndexPath
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = [collectionView
	                              dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
//不用进行if判断，如果上面复用回收池中没有cell，那么会通过上面registerClass操作自动创建新的cell
	//if(!cell){
//        cell = [[UICollectionViewCell alloc]init];
//    }

	cell.backgroundColor = [UIColor redColor];



	return cell;
}

//通过indexPath去指定修改哪些item的size。 属于UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
        layout:(UICollectionViewLayout *)collectionViewLayout
        sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.item % 3 == 0) {
		return CGSizeMake(self.view.frame.size.width, 150);
	}
	else{
		return CGSizeMake((self.view.frame.size.width-10)/2, 300);
	}
}
/*
 #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */

@end
