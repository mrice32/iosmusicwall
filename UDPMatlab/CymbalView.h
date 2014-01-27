//
//  CymbalView.h
//  UDPMatlab
//
//  Created by Matthew Rice on 10/24/13.
//  Copyright (c) 2013 Matthew Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

enum DRUM_TYPE
{
    CYMBAL,
    BASS_DRUM,
    SNARE,
    NO_DRUM
};

@class CymbalView;

@protocol DrumViewDelegate <NSObject>
@required
- (void) didTapChangeDrumInView:(CymbalView *)view withCurrentDrumType:(enum DRUM_TYPE)drumType;
@end

@interface CymbalView : UIView
{
    enum DRUM_TYPE type;
    NSMutableArray *note;
    NSMutableArray *centers;
    CGPoint center;
}

@property (assign, nonatomic) id<DrumViewDelegate> delegate;

- (void) setType:(enum DRUM_TYPE)newType withNoteArray:(NSMutableArray *)noteArray;

@end