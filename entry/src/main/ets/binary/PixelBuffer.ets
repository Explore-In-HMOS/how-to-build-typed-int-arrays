export const GRID_SIZE: number = 16;

// A 16x16 RGBA buffer: red ramps across x, green ramps down y, blue fixed.
export function buildGrid(): Uint8ClampedArray {
  const size: number = GRID_SIZE;
  const buf: Uint8ClampedArray = new Uint8ClampedArray(size * size * 4);
  for (let y = 0; y < size; y++) {
    for (let x = 0; x < size; x++) {
      const i: number = (y * size + x) * 4;
      buf[i] = x * 17;
      buf[i + 1] = y * 17;
      buf[i + 2] = 90;
      buf[i + 3] = 255;
    }
  }
  return buf;
}

export function invert(buf: Uint8ClampedArray): Uint8ClampedArray {
  const out: Uint8ClampedArray = new Uint8ClampedArray(buf.length);
  for (let i = 0; i < buf.length; i += 4) {
    out[i] = 255 - buf[i];
    out[i + 1] = 255 - buf[i + 1];
    out[i + 2] = 255 - buf[i + 2];
    out[i + 3] = buf[i + 3];
  }
  return out;
}

export function brighten(buf: Uint8ClampedArray, delta: number): Uint8ClampedArray {
  const out: Uint8ClampedArray = new Uint8ClampedArray(buf.length);
  for (let i = 0; i < buf.length; i += 4) {
    // Clamp is the lesson: any channel + delta above 255 is stored as 255,
    // never wrapping to a small number the way a plain Uint8Array would.
    out[i] = buf[i] + delta;
    out[i + 1] = buf[i + 1] + delta;
    out[i + 2] = buf[i + 2] + delta;
    out[i + 3] = buf[i + 3];
  }
  return out;
}
