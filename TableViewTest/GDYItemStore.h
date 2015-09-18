//
//  GDYItemStore.h
//  TableViewTest
//
//  Created by danyu on 9/17/15.
//  Copyright (c) 2015 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GDYItem;

@interface GDYItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (GDYItem *) createItem;
- (void)removeItem:(GDYItem *)item;
-(void)moveItemAtIndex:(NSUInteger)fromIndex
               toIndex:(NSUInteger)toIndex;

@end
