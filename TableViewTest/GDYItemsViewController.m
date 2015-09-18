//
//  GDYItemsViewController.m
//  TableViewTest
//
//  Created by danyu on 9/17/15.
//  Copyright (c) 2015 baidu. All rights reserved.
//

#import "GDYItemsViewController.h"
#import "GDYItemStore.h"
#import "GDYItem.h"

@interface GDYItemsViewController ()

@property(nonatomic, strong) UIView *headerView;
@property(nonatomic, strong) UIButton *leftBtn;
@property(nonatomic, strong) UIButton *rightBtn;

@end

@implementation GDYItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *head = self.headerView;
    [self.tableView setTableHeaderView:head];

    self.tableView.frame = CGRectMake(0, self.headerView.bounds.size.height+100,
                                      self.view.bounds.size.width,
                                      self.view.bounds.size.height-self.headerView.bounds.size.height);
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -init method 
- (instancetype)init {
    
    self = [super initWithStyle:UITableViewStylePlain];
    
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[[GDYItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *items = [[GDYItemStore sharedStore] allItems];

    GDYItem *item= items[indexPath.row];
    cell.textLabel.text = [item description];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *items = [[GDYItemStore sharedStore] allItems];
    if (indexPath.row < [items count]) {
        return 60;
    } else {
        return 0;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSArray *items = [[GDYItemStore sharedStore] allItems];
        GDYItem *item = items[indexPath.row];
        [[GDYItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 
    [[GDYItemStore sharedStore] moveItemAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

//修改删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    NSArray *items = [[GDYItemStore sharedStore] allItems];
    if (indexPath.row == [items count] - 1) {
        return NO;
    }
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - button action method

- (void)addNewItem:(id)sender {
    GDYItem *newItem = [[GDYItemStore sharedStore] createItem];
    NSInteger lastRow = [[[GDYItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (void)toggleEditingMode:(id)sender {
    // 视图的当前状态
    if (self.isEditing) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
    
}

#pragma mark - headView initial

- (UIView *) headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
        _headerView.backgroundColor = [UIColor clearColor];
        
        UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 0.5)];
        border.layer.borderColor = [[UIColor blackColor] CGColor];
        border.layer.borderWidth = 0.5;
        [_headerView addSubview:border];
        
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 50, 30)];
        [_leftBtn setTitle:@"Edit" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_headerView addSubview:_leftBtn];
        [_leftBtn addTarget:self action:@selector(toggleEditingMode:) forControlEvents:UIControlEventTouchUpInside];
        
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.headerView.bounds.size.width - 70, 25, 50, 30)];
        [_rightBtn setTitle:@"New" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_headerView addSubview:_rightBtn];
        [_rightBtn addTarget:self action:@selector(addNewItem:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _headerView;
    
}


@end
