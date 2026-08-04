import { util } from '@kit.ArkTS';
import { asInt8, asUint8, getSharedBuffer } from './SamplePayload';

export function toHex(value: number): string {
  const digits: string = (value & 0xFF).toString(16).toUpperCase();
  const val = digits.length < 2 ? `0${digits}` : digits;
  return `0x${val}`;
}

export class TypeCheck {
  label: string = '';
  value: boolean = false;

  constructor(label: string, value: boolean) {
    this.label = label;
    this.value = value;
  }
}

export function inspectPayload(): TypeCheck[] {
  const types: util.types = new util.types();
  const u8: Uint8Array = asUint8();
  const i8: Int8Array = asInt8();
  const buffer: ArrayBuffer = getSharedBuffer();
  return [
    new TypeCheck('isUint8Array(u8)', types.isUint8Array(u8)),
    new TypeCheck('isInt8Array(i8)', types.isInt8Array(i8)),
    new TypeCheck('isTypedArray(u8)', types.isTypedArray(u8)),
    new TypeCheck('isArrayBuffer(buf)', types.isArrayBuffer(buffer)),
    new TypeCheck('isArrayBufferView(u8)', types.isArrayBufferView(u8))
  ];
}
