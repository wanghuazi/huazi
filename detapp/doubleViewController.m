//
//  doubleViewController.m
//  detapp
//
//  Created by wanghaohua on 15/5/19.
//  Copyright (c) 2015年 det. All rights reserved.
//

#import "doubleViewController.h"
#import "Header.h"
#import "editDoubleViewController.h"

@interface doubleViewController ()

@end

@implementation doubleViewController

@synthesize titles;

- (void)viewDidLoad {
    self.titles = @[@"home", @"Profile", @"Chats", @"john"];
    [super viewDidLoad];
    SOCKETLAST.delegate = self;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"组合控制";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.tabBarController.tabBar.hidden) {
        [self.tabBarController.tabBar setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testButton:(id)sender {
    editDoubleViewController *editdouble = [[editDoubleViewController alloc] initWithNibName:@"editDoubleViewController.h" bundle:nil];
    [self.navigationController pushViewController:editdouble animated:YES];
}

//- (IBAction)testButton:(id)sender {
//    NSString *aString = @"bbbsss";
//    NSData *aData = [aString dataUsingEncoding: NSUTF8StringEncoding];
//    [SOCKETLAST writeData:aData];
//}
#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark UITableView Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"menuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    
    return cell;
}



#pragma mark socketControllerDelegate
-(void)readData:(NSData *)data
{
    NSLog(@"login readData %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

-(void)socketStatus:(BOOL)status
{
    NSLog(@"login socketStatus");
}


@end
