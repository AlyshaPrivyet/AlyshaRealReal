//
//  FunctionViewController.m
//  RealReal
//
//  Created by alysha on 2016/12/10.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import "FunctionViewController.h"
#import "Tools.h"
#import "MakeAddressBook.h"
#import "ContactsCell.h"
#import "Person.h"



@interface FunctionViewController ()
{
    NSMutableArray *contentArray;
}
@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = YES;
    _numberInputer.keyboardType = UIKeyboardTypePhonePad;

    _contentTable.delegate = self;
    _contentTable.dataSource = self;
        [self getAddressBook];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio
{
    return contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactsCell *cell = [[ContactsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContactsCell"];
    Person *person = [[Person alloc]init];
    person = [contentArray objectAtIndex:indexPath.row];
    cell.peopleNum.text=[NSString stringWithFormat:@"phone:%@",person.phone];
    cell.peopleName.text = person.name;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"XXX");
}

-(void)getAddressBook
{
    MakeAddressBook *abMaker = [[MakeAddressBook alloc]init];
    [abMaker getAddressBook];
//    contentArray = [[NSMutableArray alloc]init];
//    contentArray = array;
//    [_contentTable reloadData];
}

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
