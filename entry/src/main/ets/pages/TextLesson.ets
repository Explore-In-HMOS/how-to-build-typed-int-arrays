import { LessonBackButton, LessonHeader } from '../common/components/LessonScaffold';
import { TakeawayCard } from '../common/components/TakeawayCard';
import { textCodeUnits } from '../binary/SamplePayload';
import { decodeUtf16le, decodeUtf8, encodeUtf8 } from '../binary/TextCodec';
import { toHex } from '../binary/TypedArrayInspector';

class CodeUnit {
  index: number = 0;
  hex: string = '';
  glyph: string = '';

  constructor(index: number, hex: string, glyph: string) {
    this.index = index;
    this.hex = hex;
    this.glyph = glyph;
  }
}

const ROUNDTRIP_INPUT: string = 'Watch: HMS ✓';
const UNITS: Uint16Array = textCodeUnits();
const DECODED: string = decodeUtf16le(textCodeUnits());
const ENCODED_BYTES: Uint8Array = encodeUtf8(ROUNDTRIP_INPUT);
const ROUNDTRIP_OUTPUT: string = decodeUtf8(encodeUtf8(ROUNDTRIP_INPUT));

function textCells(): CodeUnit[] {
  const rows: CodeUnit[] = [];
  for (let i = 0; i < UNITS.length; i++) {
    const cu: number = UNITS[i];
    const val = cu.toString(16).toUpperCase().padStart(4, '0');
    rows.push(new CodeUnit(i, `0x${val}`, String.fromCharCode(cu)));
  }
  return rows;
}

function bytesPreview(): string {
  const parts: string[] = [];
  for (let i = 0; i < ENCODED_BYTES.length; i++) {
    parts.push(toHex(ENCODED_BYTES[i]));
  }
  return parts.join(' ');
}

const CELLS: CodeUnit[] = textCells();
const BYTES_PREVIEW: string = bytesPreview();

@Builder
function textScaffoldContent() {
  Column() {
    Text('UTF-16 code units are just numbers. Re-view them as bytes and decode.')
      .fontSize(11)
      .fontColor('#9AA6AD')
      .width('100%')
      .textAlign(TextAlign.Center)
      .margin({ bottom: 12 })

    Column() {
      Text('Uint16Array code units')
        .fontSize(11)
        .fontColor('#8FD3E8')
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 6 })
      ForEach(CELLS, (cell: CodeUnit) => {
        Row() {
          Text(`[${cell.index}]`)
            .fontSize(11)
            .fontColor('#9AA6AD')
            .width('22%')
            .textAlign(TextAlign.Start)
          Text(cell.hex)
            .fontSize(12)
            .fontColor('#EAF6FA')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Text(cell.glyph)
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .fontColor('#6FD08C')
            .width('22%')
            .textAlign(TextAlign.End)
        }
        .width('100%')
        .padding({ top: 4, bottom: 4 })
        .border({ width: { bottom: 0.5 }, color: '#1C242A' })
      }, (cell: CodeUnit) => `${cell.index}-${cell.hex}`)
    }
    .width('100%')
    .padding(10)
    .borderRadius(12)
    .backgroundColor('#12171B')

    Column() {
      Text('utf-16le decodeToString →')
        .fontSize(11)
        .fontColor('#9AA6AD')
        .width('100%')
        .textAlign(TextAlign.Center)
      Text(DECODED)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#F2F5F7')
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 6 })
    }
    .width('100%')
    .padding(14)
    .margin({ top: 12 })
    .borderRadius(12)
    .backgroundColor('#12171B')

    Column() {
      Text('UTF-8 round-trip')
        .fontSize(11)
        .fontColor('#8FD3E8')
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 6 })
      Text(`in:  ${ROUNDTRIP_INPUT}`)
        .fontSize(11)
        .fontColor('#D6E2E8')
        .width('100%')
      Text(`bytes: ${ENCODED_BYTES.length}`)
        .fontSize(10)
        .fontColor('#9AA6AD')
        .width('100%')
        .margin({ top: 4 })
      Text(BYTES_PREVIEW)
        .fontSize(9)
        .fontColor('#7E8B92')
        .width('100%')
        .margin({ top: 2 })
      Text(`out: ${ROUNDTRIP_OUTPUT}`)
        .fontSize(11)
        .fontColor('#D6E2E8')
        .width('100%')
        .margin({ top: 4 })
      Row() {
        Text('in == out')
          .fontSize(11)
          .fontColor('#D6E2E8')
          .layoutWeight(1)
        Text(ROUNDTRIP_INPUT === ROUNDTRIP_OUTPUT ? 'true' : 'false')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(ROUNDTRIP_INPUT === ROUNDTRIP_OUTPUT ? '#6FD08C' : '#E06F6F')
      }
      .width('100%')
      .margin({ top: 6 })
    }
    .width('100%')
    .padding(12)
    .margin({ top: 12 })
    .borderRadius(12)
    .backgroundColor('#12171B')

    Column() {
      TakeawayCard('Text is just bytes: UTF-16 code units → string.')
    }
    .width('100%')
    .margin({ top: 12 })
  }
  .width('100%')
  .margin({ top: 12 })
}

@Builder
export function TextLessonContent() {
  Scroll() {
    Column() {
      LessonHeader('L3 · Text')
      textScaffoldContent()
      LessonBackButton()
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .padding({ left: 14, right: 14 })
  }
  .width('100%')
  .height('100%')
  .backgroundColor('#0A0D0F')
  .scrollBar(BarState.Off)
  .edgeEffect(EdgeEffect.Spring)
}
