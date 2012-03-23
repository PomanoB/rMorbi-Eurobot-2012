
#define PLANE_COUNT 50
#define MAX_WORK_TIME 90*1000

typedef struct
{
  uint16 len;
  uint8 dir;
  uint8 speed;
  uint8 condition;
  uint8 goTo;
  uint8 type;
} planeUnit;

typedef void(* engineCorrector)(void);

#define ALLOW_WORK 0
#define STOP_ENGINES 1

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
  planeUnit planes[PLANE_COUNT];
  
  int flags;
  
  int startTime;

} g_robotState;


void resetState()
{
    g_robotState.leftEncoder = 0;
    g_robotState.rightEncoder = 0;
    g_robotState.leftPWM = 0;
    g_robotState.rightPWM = 0;
    g_robotState.corrector = 0;
    
    g_robotState.currPlane = 0;
    g_robotState.currLen = 0;
    
    g_robotState.startTime = 0;
    
    RESET_FLAG(ALLOW_WORK);
    RESET_FLAG(STOP_ENGINES);
    
    for(int i = 0; i < PLANE_COUNT; i++)
    {
      g_robotState.planes[i].len = 0;
      g_robotState.planes[i].dir = 0;
      g_robotState.planes[i].speed = 0;
      g_robotState.planes[i].condition = COND_NONE;
      g_robotState.planes[i].goTo = 0;
      g_robotState.planes[i].type = 0;
    }
}

void setup() 
{
  resetState();   
  initEngineTimer(40000);
}

void loop() 
{
   if ((millis() - g_robotState.startTime) > MAX_WORK_TIME || !GET_FLAG(ALLOW_WORK) || GET_FLAG(STOP_ENGINES)) 
   {
      stopEngines(); 
      return;
   }     
 //  correctEngines();  
}
