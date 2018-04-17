//
//  CNightTileOverlay.m
//  contact
//
//  Created by Vladimir Psyukalov on 09.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CNightTileOverlay.h"


@implementation CNightTileOverlay

+ (instancetype)tileOverlay {
    return [[CNightTileOverlay alloc] initWithURLTemplate:@"https://mts0.google.com/vt/lyrs=m@289000001&hl=en&src=app&x={x}&y={y}&z={z}&s=DGal&apistyle=s.t%3Aundefined%7Cs.e%3Ag%7Cp.c%3A%23ff1d2247%2Cs.t%3Aundefined%7Cs.e%3Ag.s%7Cp.c%3A%23ff2b3980%2Cs.t%3Aundefined%7Cs.e%3Al.i%7Cp.s%3A-100%7Cp.v%3Aoff%2Cs.t%3Aundefined%7Cs.e%3Al.t.f%7Cp.c%3A%23ffc2d8ff%2Cs.t%3Aundefined%7Cs.e%3Al.t.s%7Cp.c%3A%23ff1a3646%7Cp.v%3Aoff%2Cs.t%3A17%7Cs.e%3Ag.s%7Cp.c%3A%23ff4b6878%2Cs.t%3A21%7Cs.e%3Al.t.f%7Cp.c%3A%23ff64779e%2Cs.t%3A18%7Cs.e%3Ag.s%7Cp.c%3A%23ff4b6878%2Cs.t%3A81%7Cs.e%3Ag.s%7Cp.c%3A%23ff334e87%2Cs.t%3A82%7Cs.e%3Ag%7Cp.c%3A%23ff1c0f47%2Cs.t%3A2%7Cs.e%3Ag%7Cp.c%3A%23ff32374d%2Cs.t%3A2%7Cs.e%3Al.t.f%7Cp.c%3A%23fff3faff%2Cs.t%3A2%7Cs.e%3Al.t.s%7Cp.c%3A%23ff1d2c4d%7Cp.v%3Aoff%2Cs.t%3A40%7Cs.e%3Ag.f%7Cp.c%3A%23ff2f3248%2Cs.t%3A40%7Cs.e%3Al.t.f%7Cp.c%3A%23ff7aa2e9%2Cs.t%3A3%7Cs.e%3Ag%7Cp.c%3A%23ff164795%2Cs.t%3A3%7Cs.e%3Al.t.f%7Cp.c%3A%23ffb5c4e2%2Cs.t%3A3%7Cs.e%3Al.t.s%7Cp.c%3A%23ff1d2c4d%2Cs.t%3A49%7Cs.e%3Ag%7Cp.c%3A%23ff1e62c4%2Cs.t%3A49%7Cs.e%3Ag.s%7Cp.c%3A%23ff255763%7Cp.v%3Aoff%2Cs.t%3A49%7Cs.e%3Al.t.f%7Cp.c%3A%23ffd3e1eb%2Cs.t%3A49%7Cs.e%3Al.t.s%7Cp.c%3A%23ff023e58%2Cs.t%3A4%7Cs.e%3Al.t.f%7Cp.c%3A%23ff98a5be%2Cs.t%3A4%7Cs.e%3Al.t.s%7Cp.c%3A%23ff1d2c4d%2Cs.t%3A65%7Cs.e%3Ag.f%7Cp.c%3A%23ff666880%2Cs.t%3A66%7Cs.e%3Ag%7Cp.c%3A%23ff3a4762%2Cs.t%3A6%7Cs.e%3Ag%7Cp.c%3A%23ff171a37%2Cs.t%3A6%7Cs.e%3Al.t.f%7Cp.c%3A%23ffb5d3ed" identifier:@"night_mode_on"];
}

@end
