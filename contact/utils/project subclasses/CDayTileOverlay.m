//
//  CDayTileOverlay.m
//  contact
//
//  Created by Vladimir Psyukalov on 09.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CDayTileOverlay.h"


@implementation CDayTileOverlay

+ (instancetype)tileOverlay {
    return [[CDayTileOverlay alloc] initWithURLTemplate:@"https://mts0.google.com/vt/lyrs=m@289000001&hl=en&src=app&x={x}&y={y}&z={z}&s=DGal&apistyle=s.t%3Aundefined%7Cs.e%3Ag%7Cp.c%3A%23ffbdcee7%2Cs.t%3Aundefined%7Cs.e%3Al.i%7Cp.v%3Aoff%2Cs.t%3Aundefined%7Cs.e%3Al.t.f%7Cp.c%3A%23ff646c89%2Cs.t%3Aundefined%7Cs.e%3Al.t.s%7Cp.c%3A%23fff5f5f5%2Cs.t%3A21%7Cs.e%3Al.t.f%7Cp.c%3A%23ff1d2028%2Cs.t%3A2%7Cs.e%3Ag%7Cp.c%3A%23ffb3c3db%2Cs.t%3A2%7Cs.e%3Al.t.f%7Cp.c%3A%23ff646c89%2Cs.t%3A40%7Cs.e%3Ag%7Cp.c%3A%23ff8bc5f7%2Cs.t%3A40%7Cs.e%3Al.t.f%7Cp.c%3A%23ff9e9e9e%2Cs.t%3A3%7Cs.e%3Ag%7Cp.c%3A%23fffffbff%2Cs.t%3A50%7Cs.e%3Al.t.f%7Cp.c%3A%23ff6f6a94%2Cs.t%3A49%7Cs.e%3Ag%7Cp.c%3A%23ff8ea4da%2Cs.t%3A49%7Cs.e%3Al.t.f%7Cp.c%3A%23ffffffff%2Cs.t%3A49%7Cs.e%3Al.t.s%7Cp.v%3Aoff%2Cs.t%3A51%7Cs.e%3Al.t.f%7Cp.c%3A%23ff7c86aa%2Cs.t%3A65%7Cs.e%3Ag%7Cp.c%3A%23ffdfe1fd%2Cs.t%3A66%7Cs.e%3Ag%7Cp.c%3A%23ffeeeeee%2Cs.t%3A6%7Cp.c%3A%23ff9fd2ff%2Cs.t%3A6%7Cs.e%3Ag%7Cp.c%3A%23ffb6d2ff%2Cs.t%3A6%7Cs.e%3Al.t.f%7Cp.c%3A%23ff9e9e9e" identifier:@"night_mode_off"];
}

@end
