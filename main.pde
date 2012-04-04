#include <Servo.h>

#define PLANE_COUNT 50
#define MAX_WORK_TIME 90*1000

#define OPEN_DOOR_TIME 1000
#define CLOSE_DOOR_TIME 1000

#define LEFT_ENCODER_PIN 1
#define RIGHT_ENCODER_PIN 2

#define LEFT_DOOR_PIN 9
#define RIGHT_DOOR_PIN 10
#define LEFT_DOOR_MIN_PW 544
#define LEFT_DOOR_MAX_PW 2400
#define RIGHT_DOOR_MIN_PW 544
#define RIGHT_DOOR_MAX_PW 2400

typedef struct
{
  int len; // condition
  uint8 speed; // goTo
  uint8 type;
} planeUnit;

typedef void(* engineCorrector)(void);

#define ALLOW_WORK (1<<0)
#define COLLISION (1<<1)
#define ENGINE_STOPED (1<<2)

#define GET_FLAG(x) (g_robotState.flags & (1<<(x)))
#define SET_FLAG(x) (g_robotState.flags |= (1<<(x)))
#define RESET_FLAG(x) (g_robotState.flags &= ~(1<<(x)))

HardwareTimer g_engineTimer(2);

enum
{
  COND_NONE,
  COND_GO_TO,
  COND_OTHER  
};

enum
{
  DO_NOTHING,
  MOVE_FORWARD,
  MOVE_BACKWARD,
  TURN_LEFT,
  TURN_RIGHT,
  OPEN_DOOR,
  CLOSE_DOOR,
  WAIT,
  CONDITION
};


struct
{
  // Энкодеры
  int leftEncoder;
  int rightEncoder;
  int leftPWM;
  int rightPWM;
  engineCorrector corrector;
  
  /*
  int currX;
  int currY;
  */
  
  int currPlane;
  int currLen;
  int lastAddedPlane;
  planeUnit planes[PLANE_COUNT];
  int startPlaneTime;
  
  int flags;
  
  int startTime;

} g_robotState;

void setup() 
{
  noInterrupts();
  while (!SerialUSB.available())
    continue;
        
  SerialUSB.println("Start setup");       
  resetState(); 
  
  moveForward(5);
  goToPlane(4);
  moveForward(3);
  goToPlane(0);
  moveForward(4);
  goToPlane(2);
  
  initDoors();
  initEncoders();
  initRangers();
  
  initEngineTimer(1000000); // 40000
  
  SET_FLAG(ALLOW_WORK);
  interrupts();
}

void loop() 
{
  if (isCollision())
  {
    SET_FLAG(COLLISION);
  } 
  else
    RESET_FLAG(COLLISION);
  
  if ((millis() - g_robotState.startTime) > MAX_WORK_TIME)
    RESET_FLAG(ALLOW_WORK);
   
  if(!GET_FLAG(ALLOW_WORK) || GET_FLAG(COLLISION)) 
  {
    if (!GET_FLAG(ENGINE_STOPED))
      stopEngines(); 
    return;
  }
  RESET_FLAG(ENGINE_STOPED);
}
