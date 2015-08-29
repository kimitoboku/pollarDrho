module Pollardrho;

import std.math;

int gcd(uint a,uint b){
  if(b==0){
    return a;
  }else{
    return gcd(b,a%b);
  }
}


int multMod(uint a,uint b,uint m){
  int res = 0;
  a = a % m;
  while(b != 0){
    if((b&1) != 0){
      res = (res + a) % m;
    }
    a = (a*2)%m;
    b = b/2;
  }
  return res;
}

int PollardRho(uint num,uint c){
  if(num % 2 == 0){
    return 2;
  }
  int x = 1;
  int y = 1;
  int p = 1;

  while(p == 1){
    x = (multMod(x,x,num) + c) % num;
    int ty = (multMod(y,y,num) + c) % num;
    y = (multMod(ty,ty,num) + c) % num;
    if(x == y){
      if(sqrt(float(num)) < c){
	return -1;
      }
      return PollardRho(num,c+1);
    }
    p = gcd(num,abs(x-y));
  }
  return p;
}

int[] Factor(uint num){
  int[] ret;
  while(num!=1){
    int p = PollardRho(num,2);
    if(p==-1){
      ret = ret ~ num;
      break;
    }
    num = num / p;
    ret = ret ~ p;
  }
  return ret;
}
