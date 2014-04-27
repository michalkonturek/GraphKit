//
//  ExampleListVC.m
//  GraphKit
//
//  Created by Michal Konturek on 19/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "ExampleListVC.h"

#import "ExampleBarVC.h"
#import "ExampleBarGraphVC.h"
#import "ExampleLineGraph.h"

#import "UIColor+GraphKit.h"

@interface ExampleListVC ()

@end

@implementation ExampleListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"GraphKit";
    self.view.backgroundColor = [UIColor gk_cloudsColor];
    
    self.data = @[@"Bar", @"Bar Graph", @"Line Graph"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id vc = nil;
    switch (indexPath.row) {
        case 0:
            vc = [[ExampleBarVC alloc] initWithNibName:@"ExampleBarVC" bundle:nil];;
            break;
        case 1:
            vc = [[ExampleBarGraphVC alloc] initWithNibName:@"ExampleBarGraphVC" bundle:nil];
            break;
        case 2:
            vc = [[ExampleLineGraph alloc] initWithNibName:@"ExampleLineGraph" bundle:nil];
            break;
        default:
            break;
    }
    
    [vc setTitle:[self.data objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static id cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor gk_midnightBlueColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


@end
