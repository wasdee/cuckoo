// This #include statement was automatically added by the Particle IDE.
#include "SparkTime/SparkTime.h"

#include <climits>
#define bitRead(value, bit) (((value) >> (bit)) & 0x01)
#define bitSet(value, bit) ((value) |= (1UL << (bit)))
#define bitClear(value, bit) ((value) &= ~(1UL << (bit)))
#define bitWrite(value, bit, bitvalue) (bitvalue ? bitSet(value, bit) : bitClear(value, bit))
#define bit(b) (1UL << (b))

#define PI 3.1415926535897932384626433832795
#define HALF_PI 1.5707963267948966192313216916398
#define TWO_PI 6.283185307179586476925286766559
#define DEG_TO_RAD 0.017453292519943295769236907684886
#define RAD_TO_DEG 57.295779513082320876798154814105
typedef uint16_t word;
#define abs(x) ((x)>0?(x):-(x))
#define radians(deg) ((deg)*DEG_TO_RAD)
#define degrees(rad) ((rad)*RAD_TO_DEG)
#define sq(x) ((x)*(x))

#define lowByte(w) ((uint8_t) ((w) & 0xff))
#define highByte(w) ((uint8_t) ((w) >> 8))

UDP UDPClient;
SparkTime rtc;
unsigned long currentTime;
unsigned long lastTime = 0UL;
String timeStr;
int timezone = 0;

const byte numPins = 8;
byte pins[] = {0,1,2,3,4,5,6,7};
bool sw[] = {false, true, false, false};

bool alarmOnceSet = false;
bool timeOnceSet = false;
int alarmHour = 0;
int alarmMinute = 0;
int isRinging = 0xf;

void setup() {
    Particle.publish("devStatus", "Device ON - cuckoo activate!");
    
    Particle.function("setAlarm", setAlarmOnFPGA);
    Particle.function("updateTime", setTimeOnFPGA);
    //Particle.function("set Timezone", setTimezone);
    Particle.function("ringASecond", ringAFewSecond);
    Particle.function("triggerRing", triggerRing);
    Particle.function("setTimezone", setTimezone);
    
    Particle.function("imInBangkok", imInBangkok);
    Particle.function("imInTokyo", imInTokyo);
    Particle.function("imInDubai", imInDubai);
    Particle.function("imInSanFrans", imInSanFrans);
    Particle.function("imInNewYork", imInNewYork);
    Particle.function("imInShanghai", imInShanghai);
    Particle.function("imInSydney", imInSydney);
    
    
    Particle.variable("alarmHour", alarmHour);
    Particle.variable("alarmMinute", alarmMinute);
    Particle.variable("isRinging", isRinging);
    Particle.variable("timezone", timezone);
    
    //internet time sync
    rtc.begin(&UDPClient, "north-america.pool.ntp.org");
    rtc.setUseEuroDSTRule(true);
    rtc.setUseDST(false);
    rtc.setTimeZone(7); // gmt offset
    

    //set pin D0-D7 to be output
    for(int i=0;i<numPins;i++){
        pinMode(i, OUTPUT);
    }
    //setOpPins(0x8);
    //setDataPins(0xf);

    //set pin A0-A3 to be input
    for(int i=10;i<14;i++){
        pinMode(i, INPUT);
    }
    setIdleStateOnFPGA();

    //set debug LED
    pinMode(A4, OUTPUT); //FGPA Programmed?
    pinMode(A5, OUTPUT); //internet?

    delay(1000);
    reportState();
}

void loop() {
   /* if(isRinging != 0xf){
        if(timeOnceSet == true){
            //check if an hour already
        }else{
            setTimeOnFPGA();
        }
    }
    delay(1000*5);
    reportState();*/
}

// for GMT -7 use -7 but for GMT +7 use 6
//eg (GMT+,DST) -8
int setTimezone(String timezoneArg){
    int commaIndex = timezoneArg.indexOf(',');
    
    int gmt = timezoneArg.substring(0,commaIndex).toInt();
    String dst = timezoneArg.substring(commaIndex);
    if(dst == "true"){
        rtc.setUseDST(true);
    }else{
        rtc.setUseDST(false);
    }
    rtc.setTimeZone(gmt);
    setTimeOnFPGA("");
    Particle.publish("debug", "run setTimezone, tz="+String(gmt)+" dst="+dst);
    return 1;
}

int imInSanFrans(String dummy){
    timezone=-7;
    rtc.setTimeZone(timezone);
    Particle.publish("debug", "run setTimezone, tz="+String(timezone));
    return 1;
}

int imInTokyo(String dummy){
    timezone=9;
    rtc.setTimeZone(timezone);
    Particle.publish("debug", "run setTimezone, tz="+String(timezone));setTimeOnFPGA("");
    return 1;
}

int imInBangkok(String dummy){
    timezone=7;
    rtc.setTimeZone(timezone);
    Particle.publish("debug", "run setTimezone, tz="+String(timezone));setTimeOnFPGA("");
    return 1;
}

int imInMoscow(String dummy){
    Particle.publish("debug", "run setTimezone, tz="+String(timezone));setTimeOnFPGA("");
    timezone=3;
    rtc.setTimeZone(timezone);
    return 1;
}

int imInDubai(String dummy){
    Particle.publish("debug", "run setTimezone, tz="+String(timezone));setTimeOnFPGA("");
    timezone=4;
    rtc.setTimeZone(timezone);
    return 1;
}

int imInNewYork(String dummy){
    timezone=-4;
    rtc.setTimeZone(timezone);
    Particle.publish("debug", "run setTimezone, tz="+String(timezone));setTimeOnFPGA("");
    return 1;
}

int imInShanghai(String dummy){
    timezone=8;
    rtc.setTimeZone(timezone);
    Particle.publish("debug", "run setTimezone, tz="+String(timezone));setTimeOnFPGA("");
    return 1;
}

int imInSydney(String dummy){
    timezone=0;
    rtc.setTimeZone(timezone);
    Particle.publish("debug", "run setTimezone, tz="+String(timezone));setTimeOnFPGA("");
    return 1;
}

int imInCapetown(String dummy){
    timezone=0;
    rtc.setTimeZone(timezone);
    Particle.publish("debug", "run setTimezone, tz="+String(timezone));setTimeOnFPGA("");
    return 1;
}

int imInHonolulu(String dummy){
    timezone=-10;
    rtc.setTimeZone(timezone);
    Particle.publish("debug", "run setTimezone, tz="+String(timezone));setTimeOnFPGA("");
    return 1;
}

int imInLondon(String dummy){
    
    timezone=0;
    Particle.publish("debug", "run setTimezone, tz="+String(timezone));setTimeOnFPGA("");
    rtc.setTimeZone(timezone);
    return 1;
}

void checkInternet(){
    if(WiFi.ready())digitalWrite(A5, HIGH);
    else digitalWrite(A5, LOW);
}

void reportState(){
    checkInternet();
    short state = 0;
    for(int i=0;i<4;i++){
        bitWrite(state, i, digitalRead(10+i));
    }
    digitalWrite(A4,LOW);
    switch (state) {
        case 0: Particle.publish("fpgaStatus", "normal"); break;
        case 1: Particle.publish("fpgaStatus", "never Set Clock"); break;
        case 2: Particle.publish("fpgaStatus", "never Set Alarm"); break;
        case 3: Particle.publish("fpgaStatus", "ringing"); break;
        case 0xf: Particle.publish("fpgaStatus", "fpga is on but unprogramed"); digitalWrite(A4,HIGH); break;
        default: break;
    }
    isRinging = state ;
}

void setIdleStateOnFPGA(){
    setOpPins(0x0);
    setDataPins(0);
}

int setTimeOnFPGA(String dummy){
    Particle.publish("debug", "run setTimeOnFPGA");
    currentTime = rtc.now();

    short hour =  rtc.hour(currentTime);
    short hour_ = hour/10;
    short hour__ = hour-hour_*10;
    setOpPins(0xf);//1111 tenth
    delay(50);
    setDataPins(hour_);
    delay(100);
    
    setOpPins(0xe);//1110 unit
    delay(50);
    setDataPins(hour__);
    delay(100);
    
    Particle.publish("debug", "h="+String(hour_)+String(hour__));
    setIdleStateOnFPGA();

    short min =  rtc.minute(currentTime);
    short min_ = min/10;
    short min__ = min-min_*10;
    setOpPins(0xd);
    setDataPins(min_);
    delay(10);
    
    setOpPins(0xc); //1100
    setDataPins(min__);
    delay(10);
    
    setIdleStateOnFPGA();

    short second =  rtc.second(currentTime);
    short second_ = second/10;
    short second__ = second-second_*10;
    
    setOpPins(0xb);
    setDataPins(second_);
    delay(10);
    
    setOpPins(0xa); //1010
    setDataPins(second__);
    delay(10);
    setIdleStateOnFPGA();
    
    setIdleStateOnFPGA();
    Particle.publish("Debug", "Clock is seted at "+rtc.ISODateString(currentTime));
    return 1;
}

int setAlarmOnFPGA(String alarmTime){
    Particle.publish("debug", "run setAlarmOnFPGA with arg="+alarmTime);
    
    alarmHour = alarmTime.substring(0,2).toInt();
    short hour_ = alarmHour/10;
    short hour__ = alarmHour-hour_*10;
    setOpPins(0x6);
    setDataPins(hour__);
    delay(10);
    
    setOpPins(0x7);
    setDataPins(hour_);
    delay(100);
    setIdleStateOnFPGA();
    
    alarmMinute = alarmTime.substring(3).toInt();
    short min_ = alarmMinute/10;
    short min__ = alarmMinute-min_*10;
    setOpPins(0x4);
    setDataPins(min__);
    delay(10);
    setOpPins(0x5);
    setDataPins(min_);
    delay(10);
    
    Particle.publish("debug", "it took h="+alarmTime.substring(0,2)+"m="+alarmTime.substring(3));
    setIdleStateOnFPGA();
    Particle.publish("Debug", "Alarm is seted at "+String(alarmHour)+":"+String(alarmMinute));
    return 1;
}

int setAlarmNActive(String alarmTime){
    Particle.publish("debug", "run setAlarmOnFPGA with arg="+alarmTime);
    
    alarmHour = alarmTime.substring(0,2).toInt();
    short hour_ = alarmHour/10;
    short hour__ = alarmHour-hour_*10;
    setOpPins(0x6);
    setDataPins(hour__);
    setOpPins(0x7);
    setDataPins(hour_);
    setIdleStateOnFPGA();
    
    alarmMinute = alarmTime.substring(3).toInt();
    short min_ = alarmMinute/10;
    short min__ = alarmMinute-min_*10;
    setOpPins(0x4);
    setDataPins(min__);
    setOpPins(0x5);
    setDataPins(min_);
    setIdleStateOnFPGA();
    
    turnAlarm("on");
    
    Particle.publish("debug", "it took h="+alarmTime.substring(0,2)+"m="+alarmTime.substring(3));
    Particle.publish("Debug", "Alarm is seted at "+String(alarmHour)+":"+String(alarmMinute));
    return 1;
}



int turnAlarm(String onOrOff){
    if(onOrOff=="on"){
        setOpPins(0x8);
        sw[1]=true;
        updateSW();
    }else{
        setOpPins(0x8);
        sw[1]=false;
        updateSW();
    }
    
    setIdleStateOnFPGA();
    return 1;
}

int triggerRing(String dummy){
    if(sw[2]){
        setOpPins(0x8);
        sw[2]=false;
        updateSW();
    }else{
        setOpPins(0x8);
        sw[2]=true;
        updateSW();
    }
    
    setIdleStateOnFPGA();
    return 1;
}

int ringAFewSecond(String dummy){
    setOpPins(0x8);
    
    sw[2]=true;
    updateSW();
    delay(3000);
    sw[2]=false;
    updateSW();
    
    setIdleStateOnFPGA();
    return 1;
}

/*function to set pin D0-D3 to desire byte*/
void setDataPins(byte data){
    for(int i=0;i<4;i++){
        byte state = bitRead(data, i);
        delay(100);
        digitalWrite(pins[i], state);
    }
}

/*function to set pin D0-D3 to desire byte*/
void updateSW(){
    for(int i=0;i<4;i++){
        byte state = bitRead(sw[i], 0);
        delay(100);
        digitalWrite(pins[i], state);
    }
}

/*function to set pin D4-D7 to desire number*/
void setOpPins(byte data){
    for(int i=7;i>3;i--){
        byte state = bitRead(data, i-4);
        digitalWrite(pins[i], state);
    }
}
