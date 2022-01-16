//
//  GTListLoader.m
//  OneApp
//
//  Created by 冷锐鹏 on 2022/1/13.
//

#import "GTListLoader.h"
//集成afnetworking
#import <AFNetworking.h>
#import "GTListItem.h"
@implementation GTListLoader

-(void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock{
    //AFNetworking实现网络请求
//    [[AFHTTPSessionManager manager] GET:@"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"didi");
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"success");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"fail");
//    }];

    
    
    NSString *listString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL *listUrl = [NSURL URLWithString:listString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *JSONError;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
#warning 类型的检查未做
        NSArray *dataArray = [((NSDictionary*)[((NSDictionary *)jsonObject) objectForKey:@"result"]) objectForKey:@"data"];
        //要使用mutable的数据类型 都需要这样操作
        NSMutableArray *listItemArray = @[].mutableCopy;
        for (NSDictionary* info in dataArray) {
            GTListItem *listItem = [[GTListItem alloc]init];
            [listItem configWithDictionary:info];
            [listItemArray addObject:listItem];
        }
        //所有回调放进主线程。 将数据加载放在主线程中
        dispatch_async(dispatch_get_main_queue(), ^{
            if(finishBlock){
                finishBlock(error == nil,listItemArray.copy);
            }
        });
        
    }];
    [dataTask resume];
    
    //系统的网络框架进行网络请求
//    //地址string
//    NSString *URLString = @"https://space.bilibili.com/353624907?spm_id_from=333.1007.0.0";
//    //创建NSURL 封装地址
//    NSURL *listURL = [NSURL URLWithString:URLString];
//    //创建request 封装URL
//    //NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];
//    //创建Session  此处使用单例模式的sharedSession
//    NSURLSession * session = [NSURLSession sharedSession];
//    //创建task方法1:此处创建的是dataTaskWithRequest
//    //NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:listRequest];
//    //创建task方法2:   dataTaskWithURL: completionHandler方法 此方法就不需要创建request了
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"response处理");
//    }];
//    //开始请求
//    [dataTask resume];
//    NSLog(@"");
    
    
    
    
//    NSString *urlString = @"https://space.bilibili.com/353624907?spm_id_from=333.1007.0.0";
//    NSURL *listUrl = [NSURL URLWithString:urlString];
//    NSURLRequest *listRequest = [NSURLRequest requestWithURL:listUrl];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:listRequest];
}
@end
