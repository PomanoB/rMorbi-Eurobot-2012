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
    readedValue = analogRead(g_rangersPins[i]);
    if (readedValue >= g_rangersMaximums[i])
      return true;
  }
 
  return false; 
}
