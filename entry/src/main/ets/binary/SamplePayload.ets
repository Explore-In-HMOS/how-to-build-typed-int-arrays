const PAYLOAD_BYTES: number[] = [
  0xC8, 0x00, 0x80, 0x7F,
  0xFF, 0x01, 0x00, 0x80,
  0xAB, 0xCD, 0xEF, 0x12,
  0x34, 0x56, 0x78, 0x9A
];

const SHARED_BUFFER: ArrayBuffer = createSharedBuffer();

function createSharedBuffer(): ArrayBuffer {
  const buffer: ArrayBuffer = new ArrayBuffer(PAYLOAD_BYTES.length);
  const bytes: Uint8Array = new Uint8Array(buffer);
  for (let i = 0; i < PAYLOAD_BYTES.length; i++) {
    bytes[i] = PAYLOAD_BYTES[i];
  }
  return buffer;
}

export function getSharedBuffer(): ArrayBuffer {
  return SHARED_BUFFER;
}

export function byteLength(): number {
  return SHARED_BUFFER.byteLength;
}

export function asUint8(): Uint8Array {
  return new Uint8Array(SHARED_BUFFER);
}

export function asInt8(): Int8Array {
  return new Int8Array(SHARED_BUFFER);
}

export function asUint16(): Uint16Array {
  return new Uint16Array(SHARED_BUFFER);
}

export function asInt16(): Int16Array {
  return new Int16Array(SHARED_BUFFER);
}

export function asUint32(): Uint32Array {
  return new Uint32Array(SHARED_BUFFER);
}

export function asInt32(): Int32Array {
  return new Int32Array(SHARED_BUFFER);
}

export function layoutNote(): string {
  return '16 bytes, one ArrayBuffer. Byte 0 = 200 (unsigned) = -56 (signed). Each view below reads these SAME bytes.';
}

export function textCodeUnits(): Uint16Array {
  return new Uint16Array([0x0048, 0x004D, 0x0053]);
}
