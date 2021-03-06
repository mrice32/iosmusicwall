//
//  InstrumentViewsManager.h
//  UDPMatlab
//
//  Created by H. William Rice on 1/25/14.
//  Copyright (c) 2014 Matthew Rice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstantaneousScoreObject.h"
#import "GridView.h"
#import "CymbalView.h"

@interface InstrumentViewsManager : NSObject
{
    NetworkHelper *networkHelper;
}

@property (strong, nonatomic) NSArray *guitarViews;
@property (strong, nonatomic) NSArray *pianoViews;
@property (strong, nonatomic) NSArray *drumViews;

- (id) initWithGuitars:(NSArray *)guitars andPianos:(NSArray *)pianos andDrums:(NSArray *)drums andNetworkHelper:(NetworkHelper *)helper;

- (void) newInstantaneousScore:(InstantaneousScoreObject *)instantScore withTime:(int)timeIndex;

@end