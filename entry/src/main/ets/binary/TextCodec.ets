import { util } from '@kit.ArkTS';

export function encodeUtf8(s: string): Uint8Array {
  return util.TextEncoder.create('utf-8').encodeInto(s);
}

export function decodeUtf8(bytes: Uint8Array): string {
  return util.TextDecoder.create('utf-8').decodeToString(bytes);
}

export function decodeUtf16le(codeUnits: Uint16Array): string {
  // decodeToString only takes bytes, so re-view the SAME buffer as Uint8Array:
  // each 16-bit code unit becomes two little-endian bytes, no copy involved.
  const bytes: Uint8Array = new Uint8Array(codeUnits.buffer, codeUnits.byteOffset, codeUnits.byteLength);
  return util.TextDecoder.create('utf-16le').decodeToString(bytes);
}
