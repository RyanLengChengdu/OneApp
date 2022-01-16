//
//  GTListItem.m
//  OneApp
//
//  Created by 冷锐鹏 on 2022/1/14.
//

#import "GTListItem.h"


@implementation GTListItem
-(void)configWithDictionary:(NSDictionary *)dictionary{
    self.category = [dictionary objectForKey:@"category"];
    self.picURL = [dictionary objectForKey:@"thumbnail_pic_s"];
    self.uniqueKey = [dictionary objectForKey:@"uniquekey"];
    self.title = [dictionary objectForKey:@"title"];
    self.date = [dictionary objectForKey:@"date"];
    self.authorName = [dictionary objectForKey:@"author_name"];
    self.articleURL = [dictionary objectForKey:@"url"];
}
@end
