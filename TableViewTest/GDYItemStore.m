//
//  GDYItemStore.m
//  TableViewTest
//
//  Created by danyu on 9/17/15.
//  Copyright (c) 2015 baidu. All rights reserved.
//

#import "GDYItemStore.h"
#import "GDYItem.h"

@interface GDYItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation GDYItemStore

+ (instancetype)sharedStore {
    
    static GDYItemStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[GDYItemStore alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype) init {
    @throw [NSException exceptionWithName: @"Singleton"
                                   reason: @"Use+[GDYItemStore sharedStore]"
                                 userInfo: nil];
    return nil;
}

- (instancetype) initPrivate {
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems {
    return [self.privateItems copy];
}

- (GDYItem *)createItem {
    
    GDYItem *item = [GDYItem randomItem];
    
    [self.privateItems addObject:item];
    
    return item;
    
}

- (void)removeItem:(GDYItem *)item {
    
    [self.privateItems removeObjectIdenticalTo:item];
    
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    GDYItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
