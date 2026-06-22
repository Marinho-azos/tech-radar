function normalizeRingNameHoldToCaution(ring) {
  if ((ring || '').trim().toLowerCase() === 'hold') {
    return 'Cuidado'
  }
  return ring
}

module.exports = { normalizeRingNameHoldToCaution }
