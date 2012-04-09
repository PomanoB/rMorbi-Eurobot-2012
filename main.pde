#include <Servo.h>

#define DEGRESS(x) (53*(x))
#define SM(x) (1013*(x))

#define PLANE_COUNT 50
#define MAX_WORK_TIME 90*1000

#define OPEN_DOOR_TIME 1000
#define CLOSE_DOOR_TIME 1000

//#define LEFT_ENCODER_PIN 1
//#define RIGHT_ENCODER_PIN 2
#define RIGHT_ENCODER_PIN_A 39
#define RIGHT_ENCODER_PIN_B 37
#define LEFT_ENCODER_PIN_A 40
#define LEFT_ENCODER_PIN_B 26

#define LEFT_DOOR_PIN 6
#define RIGHT_DOOR_PIN 28

#define LEFT_ENGINE_A 32
#define LEFT_ENGINE_B 31
#define LEFT_ENGINE_E 35
#define RIGHT_ENGINE_A 33
#define RIGHT_ENGINE_B 34
#define RIGHT_ENGINE_E 36

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
  OPEN_LEFT_DOOR,
  OPEN_RIGHT_DOOR,
  CLOSE_RIGHT,
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

  resetState(); 
  /*
  moveForward(2000);
  turnLeft(2000);
  moveForward(2000);
  turnRight(2000);
  moveBackward(2000);
  */
  moveForward(SM(40));
  turnRight(35000);
  wait(3000);
//  moveForward(5000);
//  turnLeft(900);
//  turnRight(900);
//  moveForward(3000);
  
//  initDoors();
  initEncoders();
//  initRangers();
  initEngines();
  
  initEngineTimer(40000); // 40000
  
  SET_FLAG(ALLOW_WORK);
  SET_FLAG(ENGINE_STOPED);
  
  interrupts();
}

void loop() 
{
  if(!GET_FLAG(ALLOW_WORK))
    return;
  /*
  if (isCollision())
  {
    SET_FLAG(COLLISION);
  } 
  else
    RESET_FLAG(COLLISION);
  */
  if ((millis() - g_robotState.startTime) > MAX_WORK_TIME)
  {
    RESET_FLAG(ALLOW_WORK);
    stopEngines();
    noInterrupts();
  }
   
  if(GET_FLAG(COLLISION)) 
  {
    if (!GET_FLAG(ENGINE_STOPED))
      stopEngines(); 
    return;
  }
  RESET_FLAG(ENGINE_STOPED);

}
