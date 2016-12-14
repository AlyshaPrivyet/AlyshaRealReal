//
//  ContactsCell.m
//  RealReal
//
//  Created by alysha on 2016/12/13.
//  Copyright © 2016年 alysha. All rights reserved.
//

#import "ContactsCell.h"

@interface ContactsCell()

@property (weak, nonatomic) IBOutlet UILabel *PeopleName;
@property (weak, nonatomic) IBOutlet UILabel *PeopleNum;


@end

@implementation ContactsCell

+(instancetype)cellWithTableView:(UITableView*)tableView
{
    static NSString *cellID=@"ContactCell";
    ContactsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
    
}

-(void)setPerson:(Person *)person
{
    self.PeopleName.text=person.name;
    self.PeopleNum.text=person.phone;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
