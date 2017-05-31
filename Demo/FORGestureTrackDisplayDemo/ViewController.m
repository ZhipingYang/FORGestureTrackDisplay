//
//  ViewController.m
//  FORGestureTrackDisplayDemo
//
//  Created by Daniel on 31/05/2017.
//  Copyright © 2017 Daniel. All rights reserved.
//

#import "ViewController.h"
#import "FORGestureTrack.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0: [self showAlert]; break;
            case 1: [self showSheet]; break;
            case 2: [self showActivity]; break;
            default: break;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - action
- (void)showAlert {
    [[[UIAlertView alloc] initWithTitle:@"Alert Title" message:@"ready to debug alert view's layout" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sure", nil] show];
    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        FORGestureTrack* track = [[FORGestureTrack alloc] initWithFrame:window.bounds];
        track.dotWidth = 40;
        [window addSubview:track];
    });
     */
}

- (void)showSheet {
    [[[UIActionSheet alloc] initWithTitle:@"Sheet Title" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Destructive" otherButtonTitles:@"Others", nil] showInView:self.view];
}

- (void)showActivity {
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[@"Activity Title",[NSURL URLWithString:@"https://www.baidu.com"]] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}


@end
