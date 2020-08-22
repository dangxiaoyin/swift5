//
//  DXYViewController.m
//  DxySwift
//
//  Created by 945979125@qq.com on 08/20/2020.
//  Copyright (c) 2020 945979125@qq.com. All rights reserved.
//

#import "DXYViewController.h"

@interface DXYViewController ()

@end

@implementation DXYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIViewController *vc = [[NSClassFromString(@"DxySwift.Base") alloc] init];
    [self.view addSubview:vc.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
