//
//  GDYItem.m
//  TableViewTest
//
//  Created by danyu on 9/17/15.
//  Copyright (c) 2015 baidu. All rights reserved.
//

#import "GDYItem.h"

@interface GDYItem()

@property(nonatomic, strong)NSDate *dateCreated;

@end

@implementation GDYItem

+ (id)randomItem {
    
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    NSInteger adjectiveIndex = rand() % [randomAdjectiveList count];
    NSInteger nounIndex = rand() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            randomAdjectiveList[adjectiveIndex],
                            randomNounList[nounIndex]];
    int randomValue = rand() % 100;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10
    ];
    GDYItem *newItem =
    [[self alloc] initWithItemName:randomName
                    valueInDollars:randomValue
                      serialNumber:randomSerialNumber];
    
    return newItem;
    
}

- (id)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber {
    
    self = [super init];
    
    if (self) {
        self.itemName = name;
        self.valueInDollars = value;
        self.serialNumber = sNumber;
        self.dateCreated = [[NSDate alloc] init];
    }
    
    return  self;
}

- (id)init {
    return [self initWithItemName:@"item" valueInDollars:0 serialNumber:@""];
    
}

- (NSString *)description {
    NSString *descriptionString =
        [[NSString alloc] initWithFormat:@"%@ (%@):Worth $%d, recorded on %@",
         self.itemName,
         self.serialNumber,
         self.valueInDollars,
         self.dateCreated];
    
    return descriptionString;
}

@end
