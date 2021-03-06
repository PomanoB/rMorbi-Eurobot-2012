#define RANGERS_COUNT 6
uint8 g_rangersPins[RANGERS_COUNT] = {27, 20, 19, 11, 12, 10};
//uint16 g_rangersMaximums[RANGERS_COUNT] = {50, 56, 70, 73};

void initRangers()
{
  int i;
  for(i = 0; i < RANGERS_COUNT; i++)
  {
    pinMode(g_rangersPins[i], INPUT_ANALOG);
  }
}

bool isFrontCollision()
{
  if (
    (getFiltredDistance(19) > 2300 /* && getFiltredDistance(19) > 2300 && getFiltredDistance(19) > 2300 */) ||
    (getFiltredDistance(11) > 2000 /* && getFiltredDistance(11) > 2000 && getFiltredDistance(11) > 2000 */)
    )
  {
    return true; 
  }
  return false;
  
  
}
bool isBackCollision()
{
  if (
    (getFiltredDistance(27) > 2600 /* && getFiltredDistance(27) > 2600 && getFiltredDistance(27) > 2600 */) ||
    (getFiltredDistance(20) > 2600 /* && getFiltredDistance(20) > 2600 && getFiltredDistance(20) > 2600 */)
    )
  {
    return true; 
  }
  return false;
}

bool isRightCollision()
{
  if (
    (getFiltredDistance(12) > 1550 /* && getFiltredDistance(12) > 1000 && getFiltredDistance(12) > 1000 */)
    )
  {
    return true; 
  }
  return false;
}

bool isLeftCollision()
{
//  SerialUSB.println("Check left");
  if (
    (getFiltredDistance(10) > 1000 /* && getFiltredDistance(10) > 1000 && getFiltredDistance(10) > 1000 */)
    )
  {
    return true; 
  }
  return false;
}

bool isCollision()
{
  switch(g_robotState.planes[g_robotState.currPlane].type)
  {
    case MOVE_FORWARD:
       return isFrontCollision();
    case MOVE_BACKWARD:
       return isBackCollision();
    
    case TURN_LEFT:
       return isLeftCollision();
    case TURN_RIGHT:
       return false;
       return isRightCollision();
    default:
      return false;
  }
}

int getFiltredDistance(uint8 pin)
{
  uint16 result[10];
  int i;
	
  for(i = 0; i < 10; i++)
  {
    result[i] = (analogRead(pin));
    delay(20);
  }
  
  uint16 iMax1, iMax2, nMax1, nMax2;
  uint16 iMin1, iMin2, nMin1, nMin2;
  iMin1 = 99999;
  iMin2 = 99999;
  iMax1 = 0;
  iMax2 = 0;

  uint16 currVal;
  for(i = 0; i < 10; i++)
  {
    currVal = result[i];
    if (currVal > iMax1)
    {
      if (iMax1 > iMax2)
      {
        iMax2 = iMax1;
        nMax2 = nMax1;
      }
      iMax1 = currVal;
      nMax1 = i;
    }
    else
    if (currVal > iMax2)
    {
      iMax2 = currVal;
      nMax2 = i;
    }
    if (currVal < iMin1)
    {
      if (iMin1 < iMin2)
      {
        iMin2 = iMin1;
        nMin2 = nMin1;
      }
      
      iMin1 = currVal;
      nMin1 = i;
    }
    else
    if (currVal < iMin2)
    {
      iMin2 = currVal;
      nMin2 = i;
    }
  }
  
  int summ;
  summ = 0;
  for(i = 0; i < 10; i++)
  {
    if (i == nMin1 || i == nMin2 || i == nMax1 || i == nMax2)
      continue;
    summ += result[i];
  }
  summ /= 6;
  return summ;
}
