#import "FunctionViewController.h"
#import "Tools.h"
#import "MakeAddressBook.h"
#import "ContactsCell.h"
#import "Person.h"
#import "AppDelegate.h"
#import "ConverseViewController.h"


@interface FunctionViewController ()
{
     AppDelegate* appDelegate;
}
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableArray *recordPasswordArr;
@property BOOL isCaller;
@property (nonatomic) RTCPeerClient *peerClient;
@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isCaller = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInvited:) name:@"OnInvited" object:nil];
    appDelegate = (id)[[UIApplication sharedApplication]delegate];
    _peerClient = appDelegate.peerClient;
    
    self.navigationController.navigationBar.hidden = YES;
    _numberInputer.keyboardType = UIKeyboardTypePhonePad;
    _numberInputer.delegate = self;
    _recordPasswordArr = [[NSMutableArray alloc]init];
    
    _contentTable.delegate = self;
    _contentTable.dataSource = self;
    
}


- (void)onInvited:(NSNotification *)notification{
    NSDictionary* userInfo = notification.userInfo;
    if([notification.name isEqualToString:@"OnInvited"]) {
        _isCaller = NO;
        appDelegate.remoteUserId = userInfo[@"remoteUserId"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier: @"Dial" sender: self];
        });
    }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person * person=self.contentArray[indexPath.row];

        NSString *selectedNum = [person.phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [self callToSomeOne:selectedNum];
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
- (IBAction)clickToCall:(id)sender {

          NSString *remoteUserIdStr = _numberInputer.text;
                       
          _isCaller = YES;
          appDelegate.remoteUserId = remoteUserIdStr;
                     
         [_peerClient invite:remoteUserIdStr onSuccess:^{
           NSLog(@"Invite success");
           dispatch_async(dispatch_get_main_queue(), ^{
           ConverseViewController *cvc = [[ConverseViewController alloc]init];
           [self.navigationController pushViewController:cvc animated:YES];
          });
          } onFailure:^(NSError * err){
          NSLog(@"Invite failed");
          }];
    
    
}


-(void)callToSomeOne:(NSString *)Hisnumber
{
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       _isCaller = YES;
                       [_peerClient invite:Hisnumber onSuccess:^{
                           NSLog(@"Invite success");
                           dispatch_async(dispatch_get_main_queue(), ^{
                               ConverseViewController *cvc = [[ConverseViewController alloc]init];
                               [self.navigationController pushViewController:cvc animated:YES];
                           });
                       } onFailure:^(NSError * err){
                           NSLog(@"Invite failed");
                       }];
                   });

}

@end


















