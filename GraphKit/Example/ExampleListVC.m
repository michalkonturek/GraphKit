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

//NS_ENUM(NSInteger, <#_name#>)

@interface ExampleListVC ()

@end

@implementation ExampleListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"GraphKit";
    
    self.data = @[@"Bar", @"Bar Graph"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
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
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
//    self.window.rootViewController =
//    self.window.rootViewController = [[BarGraphViewVC alloc] initWithNibName:@"BarGraphViewVC" bundle:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static id cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    
    return cell;
}


@end
