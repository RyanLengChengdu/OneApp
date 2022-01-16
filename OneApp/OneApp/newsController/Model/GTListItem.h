//
//  GTListItem.h
//  OneApp
//
//  Created by 冷锐鹏 on 2022/1/14.
//

#import <Foundation/Foundation.h>
/// 列表结构化数据
NS_ASSUME_NONNULL_BEGIN

/// <#Description#>
@interface GTListItem : NSObject
@property(nonatomic,copy,readwrite)NSString *category;
@property(nonatomic,copy,readwrite)NSString *picURL;
@property(nonatomic,copy,readwrite)NSString *uniqueKey;
@property(nonatomic,copy,readwrite)NSString *title;
@property(nonatomic,copy,readwrite)NSString *date;
@property(nonatomic,copy,readwrite)NSString *authorName;
@property(nonatomic,copy,readwrite)NSString *articleURL;

//解析获取到的dictionary
-(void)configWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
