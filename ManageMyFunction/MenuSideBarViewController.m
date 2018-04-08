//
//  MenuSideBarViewController.m
//  ManageMyFunction
//
//  Created by Anveshak on 11/13/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import "MenuSideBarViewController.h"
#import "Customcell.h"
#import "VenueDetailViewController.h"
#import "CatererViewController.h"
#import "PhotoGraphViewController.h"
@interface MenuSideBarViewController ()
{
    BOOL isSideViewOpen;
}
@end

@implementation MenuSideBarViewController
@synthesize sidebar,sideview,arrdata;
- (void)viewDidLoad {
    [super viewDidLoad];
    sidebar.backgroundColor=[UIColor groupTableViewBackgroundColor];
    sideview.hidden=YES;
    isSideViewOpen=false;
    Customcell *cell=[[Customcell alloc]init];
    cell.strimg=@"venue.png";
    cell.strlbl=@"Venue";
    
    Customcell *cell1=[[Customcell alloc]init];
    cell1.strimg=@"venue.png";
    cell1.strlbl=@"Caterer";
    
    Customcell *cell2=[[Customcell alloc]init];
    cell2.strimg=@"venue.png";
    cell2.strlbl=@"Photographer";
    
    Customcell *cell3=[[Customcell alloc]init];
    cell3.strimg=@"venue.png";
    cell3.strlbl=@"Decorater";
    
    arrdata=[[NSMutableArray alloc]initWithObjects:cell,cell1,cell2,cell3, nil];
    
    _contentView.layer.cornerRadius =30 ;
    _contentView.clipsToBounds = YES;
    
    _profilepic.layer.cornerRadius =30 ;
    _profilepic.clipsToBounds = YES;


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrdata.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    }
    Customcell *maincell=[arrdata objectAtIndex:indexPath.row];
    UIImageView *img1=(UIImageView *)[cell viewWithTag:1];
    img1.image=[UIImage imageNamed:maincell.strimg];
    UILabel *lbl=(UILabel *)[cell viewWithTag:2];
    lbl.text=maincell.strlbl;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        VenueDetailViewController *venue=[self.storyboard instantiateViewControllerWithIdentifier:@"venue"];
        [self.navigationController pushViewController:venue animated:YES];
    }
    else if (indexPath.row==1){
        CatererViewController *caterer=[self.storyboard instantiateViewControllerWithIdentifier:@"caterer"];
        [self.navigationController pushViewController:caterer animated:YES];
    }
    else if (indexPath.row==2){
        PhotoGraphViewController *photo=[self.storyboard instantiateViewControllerWithIdentifier:@"photo"];
        [self.navigationController pushViewController:photo animated:YES];
    }
    
}

- (IBAction)btnmenu:(id)sender {
    
    sideview.hidden=NO;
    sidebar.hidden=NO;
    [self.view bringSubviewToFront:sideview];
        if(!isSideViewOpen)
    {
        isSideViewOpen=true;
        [sideview setFrame:CGRectMake(0, 39, 0, 465)];
        [sidebar setFrame:CGRectMake(0, 0, 0, 355)];
        [UIView beginAnimations:@"TableAnimation" context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        
        [sideview setFrame:CGRectMake(0, 39, 240, 465)];
        [sidebar setFrame:CGRectMake(0, 111, 240, 355)];
        [UIView commitAnimations];
            }
        else{
            isSideViewOpen=false;
            sideview.hidden=YES;
            sidebar.hidden=YES;
            [sideview setFrame:CGRectMake(0, 39, 240, 465)];
            [sidebar setFrame:CGRectMake(0, 111, 240, 355)];
            [UIView beginAnimations:@"TableAnimation" context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2];
            
            [sideview setFrame:CGRectMake(0, 39, 0, 465)];
            [sidebar setFrame:CGRectMake(0, 0, 0, 355)];
            [UIView commitAnimations];

            
        }
}
@end
