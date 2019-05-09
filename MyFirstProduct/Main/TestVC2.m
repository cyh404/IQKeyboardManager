//
//  TestVC2.m
//  MyFirstProduct
//
//  Created by cyh on 2018/11/26.
//  Copyright © 2018年 cyh. All rights reserved.
//

#import "TestVC2.h"
#import "TestTVCell.h"

@interface TestVC2 ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_tableView registerNib:[UINib nibWithNibName:@"TestTVCell" bundle:nil] forCellReuseIdentifier:@"TestTVCell"];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //创建单元格
    TestTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TestTVCell"];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

//每个单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 106;
}

//非必要,返回每个section的头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
}

//非必要,返回每个section的尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
