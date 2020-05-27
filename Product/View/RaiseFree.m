//
//  RaiseFree.m
//  yt
//
//  Created by hxisWater on 2019/4/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "RaiseFree.h"

@implementation RaiseFree

+ (double)mymoney:(int)money mycycle:(int)cycle mylever:(int)lever fixRate:(double)fixRate {
    int interest = 210;
    bool discount = false;
    if(money && cycle && lever){
        if(money >= 1000000){
            if(cycle>=3){
                interest = 180;
            }else if(cycle>=1){
                interest = 190;
            }
        }else if(money>=100000){
            if(cycle>=3){
                interest = 190;
            }else if(cycle>=1){
                interest =200;
            }
        }else if(money>=1000){
            if(cycle>=3){
                interest = 200;
            }else if(cycle>=1){
                interest =210;
            }
        }
        if(lever<=2){
            discount = true;
            interest = interest-(5-lever+2)*10;
            if(fixRate && fixRate>1 && interest>=fixRate){
                discount = false;
                interest = fixRate;
            }
        }else if(lever<5){
            discount = true;
            interest = interest-(5-lever+1)*10;
            if(fixRate && fixRate>1 && interest>=fixRate){
                discount = false;
                interest = fixRate;
            }
        }else if(lever==5){
            discount = true;
            interest = interest-(5-lever+1)*10;
            if(fixRate && fixRate>1 && interest>=fixRate){
                discount = false;
                interest = fixRate;
            }
        }
    }
    
    if(lever==1){
        interest=120;
    }else if(lever==2){
        interest=130;
    }
    double fee = money * (interest / 10000.0);
    return (double)round(fee) * cycle;
}

+ (double)myRate:(int)money mycycle:(int)cycle mylever:(int)lever fixRate:(double)fixRate {
    int interest = 210;
    bool discount = false;
    if(money && cycle && lever){
        if(money >= 1000000){
            if(cycle>=3){
                interest = 180;
            }else if(cycle>=1){
                interest = 190;
            }
        }else if(money>=100000){
            if(cycle>=3){
                interest = 190;
            }else if(cycle>=1){
                interest =200;
            }
        }else if(money>=1000){
            if(cycle>=3){
                interest = 200;
            }else if(cycle>=1){
                interest =210;
            }
        }
        if(lever<=2){
            discount = true;
            interest = interest-(5-lever+2)*10;
            if(fixRate && fixRate>1 && interest>=fixRate){
                discount = false;
                interest = fixRate;
            }
        }else if(lever<5){
            discount = true;
            interest = interest-(5-lever+1)*10;
            if(fixRate && fixRate>1 && interest>=fixRate){
                discount = false;
                interest = fixRate;
            }
        }else if(lever==5){
            discount = true;
            interest = interest-(5-lever+1)*10;
            if(fixRate && fixRate>1 && interest>=fixRate){
                discount = false;
                interest = fixRate;
            }
        }
    }
    
    if(lever==1){
        interest=120;
    }else if(lever==2){
        interest=130;
    }
    return interest / 100.0;
}

@end
