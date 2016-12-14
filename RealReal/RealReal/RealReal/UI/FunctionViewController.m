#import "FunctionViewController.h"
#import "Tools.h"
#import "MakeAddressBook.h"
#import "ContactsCell.h"
#import "Person.h"



@interface FunctionViewController ()

@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableArray *recordPasswordArr;

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    _numberInputer.keyboardType = UIKeyboardTypePhonePad;
    _numberInputer.delegate = self;
    _recordPasswordArr = [[NSMutableArray alloc]init];
    
    _contentTable.delegate = self;
    _contentTable.dataSource = self;
    
}

-(NSMutableArray *)contentArray
{
    if(_contentArray==nil)
    {
        _contentArray=[NSMutableArray array];
        MakeAddressBook *abMaker = [[MakeAddressBook alloc]init];
        
        _contentArray =  [abMaker getAddressBook];
    }
    return _contentArray;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactsCell *cell=[ContactsCell cellWithTableView:tableView];
    cell.person=self.contentArray[indexPath.row];
    
    return cell;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.text.length+string.length>11)
    {return NO;
    }
    if(string.length==0)
    {

        [self.recordPasswordArr removeLastObject];
        NSString *recordPasswordStr=[[NSString alloc]init];
        for(int i=0;i<_recordPasswordArr.count;i++)
            recordPasswordStr=[recordPasswordStr stringByAppendingString:self.recordPasswordArr[i]];
        NSLog(@"recordPasswordStr:%@",recordPasswordStr);
        [_prepareDieBtn setTitle:recordPasswordStr forState:UIControlStateNormal];

    }
    else
    {
        [self.recordPasswordArr addObject:string];
        NSString *recordPasswordStr=[[NSString alloc]init];
        for(int i=0;i<_recordPasswordArr.count;i++)
            recordPasswordStr=[recordPasswordStr stringByAppendingString:self.recordPasswordArr[i]];
        NSLog(@"recordPasswordStr:%@",recordPasswordStr);
        [_prepareDieBtn setTitle:recordPasswordStr forState:UIControlStateNormal];

    }
    if(self.recordPasswordArr.count==11)
    {
        NSString *recordPasswordStr=[[NSString alloc]init];
        for(int i=0;i<_recordPasswordArr.count;i++)
            recordPasswordStr=[recordPasswordStr stringByAppendingString:self.recordPasswordArr[i]];
        NSLog(@"recordPasswordStr:%@",recordPasswordStr);
        [_prepareDieBtn setTitle:recordPasswordStr forState:UIControlStateNormal];
    }
    
    
    return YES;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
