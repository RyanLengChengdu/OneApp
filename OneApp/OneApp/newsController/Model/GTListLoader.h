//
//  GTListLoader.h
//  OneApp
//
//  Created by 冷锐鹏 on 2022/1/13.
//

#import <Foundation/Foundation.h>
//先声明GTListItem 后面需要使用的时候再引入
@class GTListItem;
//让ViewController获得数组，而忽略中间过程，所以要用block  下方先定义block
typedef void(^GTListLoaderFinishBlock)(BOOL success,NSArray<GTListItem *> *dataArray);
NS_ASSUME_NONNULL_BEGIN

/// 列表请求
@interface GTListLoader : NSObject
-(void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock;
@end

NS_ASSUME_NONNULL_END
