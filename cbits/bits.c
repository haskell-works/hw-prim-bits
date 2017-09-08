#include "bits.h"

uint32_t fast_pdep32(
    uint32_t src,
    uint32_t mask) {
  uint32_t result;

  __asm__ __volatile__("pdepl  %%ecx,%%ebx,%%eax"
                       :"=a"(result)
                       :"a"(result), "b"(src), "c"(mask)
                       );

  return result;
}

uint32_t slow_pdep32(
    uint32_t src,
    uint32_t mask) {
  uint32_t result = 0;

  while (1) {
    // Mask out all but the lowest bit
    const uint32_t lowest = (-mask & mask);

    if (lowest == 0) {
      break;
    }

    const uint32_t lsb = (uint32_t)((int32_t)(src << 63) >> 63);

    result |= lsb & lowest;
    mask &= ~lowest;
    src >>= 1;
  }

  return result;
}

uint64_t fast_pdep64(
    uint64_t src,
    uint64_t mask) {
  uint64_t result;

  __asm__ __volatile__("pdepq  %%rcx,%%rbx,%%rax"
                       :"=a"(result)
                       :"a"(result), "b"(src), "c"(mask)
                       );

  return result;
}

uint64_t slow_pdep64(
    uint64_t src,
    uint64_t mask) {
  uint64_t result = 0;

  while (1) {
    // Mask out all but the lowest bit
    const uint64_t lowest = (-mask & mask);

    if (lowest == 0) {
      break;
    }

    const uint64_t lsb = (uint64_t)((int64_t)(src << 63) >> 63);

    result |= lsb & lowest;
    mask &= ~lowest;
    src >>= 1;
  }

  return result;
}

uint32_t fast_pext32(
    uint32_t src,
    uint32_t mask) {
  uint32_t result;

  __asm__ __volatile__("pextl  %%ecx,%%ebx,%%eax"
                       :"=a"(result)
                       :"a"(result), "b"(src), "c"(mask)
                       );

  return result;
}

uint32_t slow_pext32(
    uint32_t src,
    uint32_t mask) {
  uint32_t result = 0;
  int offset = 0;

  for (int bit = 0; bit != sizeof(uint32_t) * 8; ++bit) {
    const uint32_t src_bit = (src >> bit) & 1;
    const uint32_t mask_bit = (mask >> bit) & 1;

    if (mask_bit) {
      result |= (uint32_t)(src_bit) << offset;
      ++offset;
    }
  }

  return result;
}

uint64_t fast_pext64(
    uint64_t src,
    uint64_t mask) {
  uint64_t result;

  __asm__ __volatile__("pextq  %%rcx,%%rbx,%%rax"
                       :"=a"(result)
                       :"a"(result), "b"(src), "c"(mask)
                       );

  return result;
}

uint64_t slow_pext64(
    uint64_t src,
    uint64_t mask) {
  uint64_t result = 0;
  int offset = 0;

  for (int bit = 0; bit != sizeof(uint64_t) * 8; ++bit) {
    const uint64_t src_bit = (src >> bit) & 1;
    const uint64_t mask_bit = (mask >> bit) & 1;

    if (mask_bit) {
      result |= (uint64_t)(src_bit) << offset;
      ++offset;
    }
  }

  return result;
}
