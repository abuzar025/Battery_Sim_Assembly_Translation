// CSCI 2021 Project 2 Bitwise Operations 
// Muhammad Abuzar 


#include "batt.h"

// int set_batt_from_ports(batt_t *batt){

//     if (BATT_VOLTAGE_PORT < 0){
//         return 1;
//     }  
// batt->mlvolts = BATT_VOLTAGE_PORT/2;
//     if (batt->mlvolts < 3000){                              // 0% battery for 3000 V or less  
//         batt->percent = 0;
//     } 
//     else if(batt->mlvolts > 3800){                                  // 100% battery for over 3800 V 
//         batt->percent = 100;
//     } 
//     else{
//         batt->percent = ((batt->mlvolts-3000)/8);               // If V in range, apply formula 
//     }

//     if (BATT_STATUS_PORT & 16 ){
//         batt-> mode = 1;                                        // mode 1 = percent
//     }
//     else{
//         batt->mode = 2;                                         // mode 2 = Voltage
//     }
//     return 0; 
// }



int set_display_from_batt(batt_t batt, int *display){
*display = 0; 
if(batt.percent >= 90){                                                                                 //Battery display over 90%
    *display= *display | (1 << 24) | (1<<25) | (1<<26) | (1<<27) | (1<<28);
}
else if(batt.percent <= 89 && batt.percent >= 70){                                                      //Battery display over 89-70%
    *display= *display | (1 << 24) | (1<<25) | (1<<26) | (1<<27);
}
else if(batt.percent <=69 && batt.percent >= 50){                                                       //Battery display over 69-50%
    *display= *display | (1 << 24) | (1<<25) | (1<<26);
}
else if(batt.percent <=49 && batt.percent >= 30){                                                       //Battery display over 49-30%
    *display= *display | (1 << 24) | (1<<25) ;
}
else if(batt.percent<=29  && batt.percent >= 5){                                                        //Battery display over 29-5%
    *display= *display | (1 << 24);
}
    
    

//             zero    one         two        three    four        five    six        seven    eight      nine     blank    negative   
int bit[12]= {0b0111111,0b0000110,0b1011011,0b1001111,0b1100110,0b1101101,0b1111101,0b0000111,0b1111111,0b1101111,0b0000000, 0b1000000};  // Bit pattren for each value 0-9, blank & negative
int perc, left_digit, right_digit;      // digit place holders 
    if(batt.mode == 1){//perc  
     perc =(int) batt.percent; 
     left_digit= perc/10;               // left digit 
     right_digit= perc%10;              // right digit 

    if(perc==100){
        *display= *display | (bit[1] << 17) | (bit[0]<< 10) | (bit[0] << 3)| 1 << 0;                                                   //show 100%
    }
    else if(perc >= 10 && perc <100){
        *display= *display | (bit[10] << 17) | (bit[left_digit]<< 10) | (bit[right_digit] << 3)| 1 << 0;                    // show 10-99% & leaving the first digit blank 
    }
    else if(perc >=0 && perc <10){
        *display= *display | (bit[10] << 17) | (bit[10]<< 10) | (bit[right_digit] << 3) | 1 << 0;                           // shows 0-10% leaving the first 2 blank digit 
    }
    else if(perc <= 0){
        *display= *display | (bit[10] << 17) | (bit[10]<< 10) | (bit[0] << 3) | 1 << 0;                                      // first 2 blank digit and last set 0% for below 
    }
    return 0;
}


int mlvol = batt.mlvolts; // volts in 4 digit 

if((mlvol%10)>=5){         // checking if last digit is greater than 5
    mlvol= (mlvol/10)+1;    // drop last digit and add one example: 3515 -> 351+2= 352
}
else{
    mlvol= mlvol/10;        // just drop last digit 
}




int left, center, right;                   // digit place holders 
left = mlvol/100;                          // left digit 
center = (((mlvol)/10)%10);                // middle digit 
right = mlvol%10;                          // right digit 

    if(batt.mode==2){ //volt
        if(mlvol==0){
            *display= *display | (bit[0] << 17) | (bit[0]<< 10) | (bit[0] << 3) | (0b11 << 1) ;                                      // return 0.00 V
        }
        else if ( mlvol > 0  && mlvol < 9 ){ 
            *display= *display | (bit[10] << 17) | (bit[10]<< 10) | (bit[right] << 3) | (0b11 << 1);                                // 9V > 1V 
        }
        else if (mlvol > 10 && mlvol < 99 ){  
            *display= *display | (bit[10] << 17) | (bit[center]<< 10) | (bit[right] << 3) | (0b11 << 1) ;                           // 99V > 10V 
        }
        else{
            *display= *display | (bit[left] << 17) | (bit[center]<< 10) | (bit[right] << 3) | (0b11 << 1) ;                         // 3.99 V
        }
    }
    return 0;
}


int batt_update(){
    batt_t batt;
    if(set_batt_from_ports(&batt) < 0 || set_batt_from_ports(&batt) == 1){
        return 1; 
    }
    else{
        set_display_from_batt(batt, &BATT_DISPLAY_PORT);
    }
    return 0;
}
