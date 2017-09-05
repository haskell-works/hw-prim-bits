#include <x86intrin.h>

unsigned long long pdep64(
  unsigned long long arga,
  unsigned long long argb)
{
  unsigned long long result;

  __asm__ __volatile__("pdepl  %%ecx,%%ebx,%%eax"
                       :"=a"(result)
                       :"a"(result), "b"(arga), "c"(argb)
                       );

  return result;
}
