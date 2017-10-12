//
//  CallOutAnnotationView.h
//  CarWashing
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <MapKit/MapKit.h>
#define  Arror_height 15

@protocol CallOutAnnotationViewDelegate;
@interface CallOutAnnotationView : MKAnnotationView
@property (nonatomic,strong)UIView *contentView;


- (id)initWithAnnotation:(id<MKAnnotation>)annotation
         reuseIdentifier:(NSString *)reuseIdentifier
                delegate:(id<CallOutAnnotationViewDelegate>)delegate;
@end

@protocol CallOutAnnotationViewDelegate <NSObject>

- (void)didSelectAnnotationView:(CallOutAnnotationView *)view;
@end
