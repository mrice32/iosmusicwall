//
//  InstrumentType.h
//  UDPMatlab
//
//  Created by Matthew Rice on 1/27/14.
//  Copyright (c) 2014 Matthew Rice. All rights reserved.
//

#import <Foundation/Foundation.h>

enum INSTRUMENT_TYPE
{
    TYPE_GUITAR = 0,
    TYPE_PIANO = 1,
    TYPE_CYMBAL = 2,
    TYPE_BASS_DRUM = 3,
    TYPE_BASS_DRUM_2 = 4,
    TYPE_CYMBAL_2 = 5,
    TYPE_SNARE = 6,
};

@interface InstrumentType : NSObject

@property (nonatomic) enum INSTRUMENT_TYPE type;

- (id) initWithType:(enum INSTRUMENT_TYPE)instrumentType;

@end
