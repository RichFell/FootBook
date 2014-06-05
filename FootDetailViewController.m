//
//  FootDetailViewController.m
//  Footbook
//
//  Created by Richard Fellure on 6/5/14.
//  Copyright (c) 2014 Rich. All rights reserved.
//

#import "FootDetailViewController.h"

@interface FootDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation FootDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

-(IBAction)addNewComment:(UITextField *)sender
{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"footCellID"];


    return cell;
}

@end
