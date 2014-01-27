//
//  GridView.m
//  UDPMatlab
//
//  Created by Matthew Rice on 10/24/13.
//  Copyright (c) 2013 Matthew Rice. All rights reserved.
//

#import "GridView.h"

@implementation GridView
@synthesize delegate;

static float const unselectedRadius = 3.0;
static float const selectedRadius = 6.0;
static float const buttonRadius = 6.0;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initCustomView:frame];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initCustomView:self.frame];
    }
    return self;
}

-(void)initCustomView:(CGRect)frame
{
    NSLog(@"Frame Height = %f, Frame Width = %f", frame.size.height, frame.size.width);
    isInstrumentGuitar = NO;
    NSMutableArray *myArray = [[NSMutableArray alloc] initWithCapacity:6];
    for (int i = 0; i < 6; i++)
    {
        [myArray addObject:[NSNumber numberWithBool:NO]];
    }
    score = myArray;
    // Initialization code
    jumpSize = frame.size.width/7.0;
    for (int i = 0; i < 6; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        switch (i)
        {
            case 0:
                [button addTarget:self
                           action:@selector(touchedNoteOne:)
                 forControlEvents:UIControlEventTouchDown];
                break;
            case 1:
                [button addTarget:self
                           action:@selector(touchedNoteTwo:)
                 forControlEvents:UIControlEventTouchDown];
                break;
            case 2:
                [button addTarget:self
                           action:@selector(touchedNoteThree:)
                 forControlEvents:UIControlEventTouchDown];
                break;
            case 3:
                [button addTarget:self
                           action:@selector(touchedNoteFour:)
                 forControlEvents:UIControlEventTouchDown];
                break;
            case 4:
                [button addTarget:self
                           action:@selector(touchedNoteFive:)
                 forControlEvents:UIControlEventTouchDown];
                break;
            case 5:
                [button addTarget:self
                           action:@selector(touchedNoteSix:)
                 forControlEvents:UIControlEventTouchDown];
                break;
            default:
                break;
        }
        [button setTitle:@"" forState:UIControlStateNormal];
        button.frame = CGRectMake(round(0.0 + (((double)(i + 1)) * jumpSize) - buttonRadius) , round(0.0 + (frame.size.height * 0.5) - buttonRadius), round(2 * buttonRadius), round(2 * buttonRadius));
        [button setBackgroundColor:[UIColor clearColor]];
        [self addSubview:button];
        NSLog(@"button %d center (X,Y) = (%0.2f, %0.2f)", i, round(button.frame.origin.x + (button.frame.size.width/2.0)), round(button.frame.origin.y + (button.frame.size.height/2.0)));
    }
    
    UIButton *instrumentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [instrumentButton addTarget:self action:@selector(touchedChangeInstrument:) forControlEvents:UIControlEventTouchDown];
    [instrumentButton setFrame:CGRectMake(round(0.0 /*- frame.size.height/4.0*/), round(0.0 /*+ (3.0 * frame.size.height/4.0)*/), round(frame.size.height/4.0), round(frame.size.height/4.0))];
    [instrumentButton setBackgroundImage:[UIImage imageNamed:@"imageedit_2_3232341617.png"] forState:UIControlStateNormal];
    [instrumentButton setBackgroundColor:[UIColor clearColor]];
    [self addSubview:instrumentButton];
}

- (void)touchedChangeInstrument:(id)sender
{
    if (delegate != nil)
    {
        [delegate didTapChangeGridInView:self withIsGuitar:isInstrumentGuitar];
    }
}



- (void)drawRect:(CGRect)rect
{
    UIImage *instrumentImage = nil;
    
    if (isInstrumentGuitar)
    {
        instrumentImage = [UIImage imageNamed:@"acoustic6string.jpg"];
    }
    else
    {
        instrumentImage = [UIImage imageNamed:@"Piano_Keyboard.jpg"];
    }
    
    [instrumentImage drawInRect:rect blendMode:kCGBlendModeNormal alpha:0.25];
    
    int i = 0;
    UIColor *myColor = [UIColor blackColor];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextMoveToPoint(context, round(rect.origin.x), round(rect.origin.y + (rect.size.height/2.0)));
    CGContextAddLineToPoint(context, round(0.0 + rect.size.width), round(0.0 + (rect.size.height / 2.0)));
    CGContextStrokePath(context);
    CGContextFillPath(context);
    
    
    float circleRadius = unselectedRadius;
    while (i < 6)
    {
        if ([[score objectAtIndex:i] boolValue])
        {
            circleRadius = selectedRadius;
            myColor = [UIColor yellowColor];
        }
        else
        {
            circleRadius = unselectedRadius;
            myColor = [UIColor blackColor];
        }
        CGContextSetFillColorWithColor(context, myColor.CGColor);
        CGContextMoveToPoint(context, round(0.0 + (((double)(i + 1)) * jumpSize)), round(0.0 + (rect.size.height * 0.25)));
        CGContextAddLineToPoint(context, round(0.0 + (((double)(i + 1)) * jumpSize)), round(0.0 + (rect.size.height * 0.75)));
        CGContextStrokePath(context);
        CGContextFillEllipseInRect(context, CGRectMake(round(0.0 + (((double)(i + 1)) * jumpSize) - circleRadius) , round(0.0 + (rect.size.height * 0.5) - circleRadius), round(2 * circleRadius), round(2 * circleRadius)));
        CGContextFillPath(context);
        i++;
    }
}

- (void)setInstrument:(bool)isGuitar withSelectedNotes:(NSMutableArray *)noteArray
{
    isInstrumentGuitar = isGuitar;
    score = noteArray;
    [self setNeedsDisplay];
}

-(void)touchedNoteSix:(id)sender
{
    int i = 5;
    if ([[score objectAtIndex:i] boolValue])
    {
        [score setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:i];
    }
    else
    {
        [score setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:i];
    }
    
    [self setNeedsDisplay];
}
-(void)touchedNoteOne:(id)sender
{
    int i = 0;
    if ([[score objectAtIndex:i] boolValue])
    {
        [score setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:i];
    }
    else
    {
        [score setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:i];
    }
    [self setNeedsDisplay];
}
-(void)touchedNoteTwo:(id)sender
{
    int i = 1;
    if ([[score objectAtIndex:i] boolValue])
    {
        [score setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:i];
    }
    else
    {
        [score setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:i];
    }
    [self setNeedsDisplay];
}
-(void)touchedNoteThree:(id)sender
{
    int i = 2;
    if ([[score objectAtIndex:i] boolValue])
    {
        [score setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:i];
    }
    else
    {
        [score setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:i];
    }
    [self setNeedsDisplay];
}
-(void)touchedNoteFour:(id)sender
{
    int i = 3;
    if ([[score objectAtIndex:i] boolValue])
    {
        [score setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:i];
    }
    else
    {
        [score setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:i];
    }
    [self setNeedsDisplay];
}
-(void)touchedNoteFive:(id)sender
{
    int i = 4;
    if ([[score objectAtIndex:i] boolValue])
    {
        [score setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:i];
    }
    else
    {
        [score setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:i];
    }
    [self setNeedsDisplay];
}

@end
