#define RANGERS_COUNT 4
uint8 g_rangersPins[RANGERS_COUNT] = {5, 6, 7, 8};
uint16 g_rangersMaximums[RANGERS_COUNT] = {50, 56, 70, 73};

void initRangers()
{
  int i;
  for(i = 0; i < RANGERS_COUNT; i++)
  {
    pinMode(g_rangersPins[i], INPUT_ANALOG);
  }
}

bool isCollision()
{
  int i;
  uint16 readedValue;
  for(i = 0; i < RANGERS_COUNT; i++)
  {
  //  readedValue = analogRead(g_rangersPins[i]);
      readedValue = getFiltredDistance(g_rangersPins[i]);
    if (readedValue >= g_rangersMaximums[i])
      return true;
  }
 
  return false; 
}

int getFiltredDistance(int pin)
{
  int result[10];
  int i;
	
  for(i = 0; i < 10; i++)
  {
    result[i] = analogRead(pin);
  }
  
  int iMax1, iMax2, nMax1, nMax2;
  int iMin1, iMin2, nMin1, nMin2;
  iMin1 = 99999;
  iMin2 = 99999;
  iMax1 = 0;
  iMax2 = 0;

  int currVal;
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
