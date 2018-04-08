//
//  PhotoDetailViewController.h
//  ManageMyFunction
//
//  Created by Anveshak on 11/3/17.
//  Copyright © 2017 Anveshak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoDetailViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *service_provider_id;
@property (strong, nonatomic) IBOutlet UILabel *eastablished_year;
@property (strong, nonatomic) IBOutlet UILabel *morning_start_time;
@property (strong, nonatomic) IBOutlet UILabel *morning_end_time;
@property (strong, nonatomic) IBOutlet UILabel *evening_start_time;
@property (strong, nonatomic) IBOutlet UILabel *evening_end_time;
@property (strong, nonatomic) IBOutlet UILabel *terms_conditions;
@property (strong, nonatomic) IBOutlet UILabel *package_name;
@property (strong, nonatomic) IBOutlet UILabel *high_resolution_photos;
@property (strong, nonatomic) IBOutlet UILabel *low_resolution_photos;
@property (strong, nonatomic) IBOutlet UILabel *short_film;
@property (strong, nonatomic) IBOutlet UILabel *long_film;
@property (strong, nonatomic) IBOutlet UILabel *no_of_days;
@property (strong, nonatomic) IBOutlet UILabel *no_of_hours_per_day;
@property (strong, nonatomic) IBOutlet UILabel *medium_of_delivery;
@property (strong, nonatomic) IBOutlet UILabel *no_of_photographers;
@property (strong, nonatomic) IBOutlet UILabel *delivery_charges;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *comments;
@property (strong, nonatomic) IBOutlet UILabel *serviceName;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *short_film_size;
@property (strong, nonatomic) IBOutlet UILabel *long_film_size;
@property (strong, nonatomic) IBOutlet UILabel *event_name;
@property (strong, nonatomic) IBOutlet UILabel *event_type_id;
@property (strong, nonatomic) IBOutlet UILabel *pdf_name;
@property (strong, nonatomic) IBOutlet UILabel *ext;
@property (strong, nonatomic) IBOutlet UILabel *path;
@property (strong, nonatomic) IBOutlet UIImageView *coverImages;



@property (strong, nonatomic) IBOutlet UILabel *event_type;
@property(nonatomic,retain)NSString *indxpath,*service_provider_id_str;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property(nonatomic,retain)NSString *facilities_str,*venue_type_name_str,*event_name_str,*service_name_str,*address_str,*terms_conditons_str,*eastablished_yr_str,*morningstart_time,*morningend_time,*eveningstart_time,*eveningend_time,*packagenameStr,*highResoStr,*lowResoStr,*shortfilmSte,*longFilmStr,*no_of_daysSStr,*no_of_hrs_str,*mediundelStr,*no_of_photograph_str,*deliveryChardesStr,*priceStr,*commentStr,*shortfilmsize_str,*lonffilmsize_str,*coverimgStr,*eventtypeidStr,*eventNameStr,*pdfnamestr,*extStr,*pathStr;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *contentview;


@end
