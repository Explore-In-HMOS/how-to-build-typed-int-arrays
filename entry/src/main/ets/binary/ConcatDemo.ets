import { collections } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';

// ConcatArray lives on collections.Array, NOT on built-in typed arrays.
// collections.Array<T> needs a Sendable T (number here) and must be built with
// the (first, ...left) constructor — the no-arg form throws 10200012.
export function collectionsConcat(): string {
  const a: collections.Array<number> = new collections.Array<number>(1, 2, 3);
  const b: collections.Array<number> = new collections.Array<number>(4, 5, 6);
  const bc: collections.ConcatArray<number> = b;
  try {
    const joined: collections.Array<number> = a.concat(bc);
    return joined.join(', ');
  } catch (err) {
    return `error ${(err as BusinessError).code}`;
  }
}

// Built-in Int16Array has no .concat(): allocate a bigger view, then copy each
// source in with .set(view, offset).
export function typedSetJoin(): string {
  const x: Int16Array = new Int16Array([10, 20, 30]);
  const y: Int16Array = new Int16Array([40, 50, 60]);
  const result: Int16Array = new Int16Array(x.length + y.length);
  result.set(x, 0);
  result.set(y, x.length);
  const parts: string[] = [];
  for (let i = 0; i < result.length; i++) {
    parts.push(`${result[i]}`);
  }
  return parts.join(', ');
}
