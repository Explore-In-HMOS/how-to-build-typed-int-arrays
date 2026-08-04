import { LessonHeader, LessonBackButton } from '../common/components/LessonScaffold';
import { ByteRow } from '../common/components/ByteRow';
import { TakeawayCard } from '../common/components/TakeawayCard';
import { asInt8, asUint8, layoutNote } from '../binary/SamplePayload';
import { inspectPayload, toHex, TypeCheck } from '../binary/TypedArrayInspector';

class ByteCell {
  index: number = 0;
  hex: string = '';
  unsignedValue: number = 0;
  signedValue: number = 0;

  constructor(index: number, hex: string, unsignedValue: number, signedValue: number) {
    this.index = index;
    this.hex = hex;
    this.unsignedValue = unsignedValue;
    this.signedValue = signedValue;
  }
}

function buildCells(): ByteCell[] {
  const u8: Uint8Array = asUint8();
  const i8: Int8Array = asInt8();
  const rows: ByteCell[] = [];
  for (let i = 0; i < u8.length; i++) {
    rows.push(new ByteCell(i, toHex(u8[i]), u8[i], i8[i]));
  }
  return rows;
}

const CELLS: ByteCell[] = buildCells();
const CHECKS: TypeCheck[] = inspectPayload();

@Builder
function bytesTableHeader() {
  Row() {
    Text('Idx').fontSize(10).fontColor('#6E7B82').width('16%').textAlign(TextAlign.Start)
    Text('Hex').fontSize(10).fontColor('#6E7B82').width('28%').textAlign(TextAlign.Center)
    Text('Unsigned').fontSize(10).fontColor('#6E7B82').width('28%').textAlign(TextAlign.Center)
    Text('Signed').fontSize(10).fontColor('#6E7B82').width('28%').textAlign(TextAlign.End)
  }
  .width('100%')
  .padding({ top: 2, bottom: 4 })
}

@Builder
export function BytesLessonContent() {
  Scroll() {
    Column() {
      LessonHeader('L1 · Bytes')

      Column() {
        Text(layoutNote())
          .fontSize(11)
          .fontColor('#9AA6AD')
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ bottom: 10 })

        Column() {
          bytesTableHeader()
          ForEach(CELLS, (cell: ByteCell) => {
            ByteRow(cell.index, cell.hex, cell.unsignedValue, cell.signedValue)
          }, (cell: ByteCell) => `${cell.index}-${cell.hex}`)
        }
        .width('100%')
        .padding(10)
        .borderRadius(12)
        .backgroundColor('#12171B')

        Column() {
          Text('util.types() checks')
            .fontSize(11)
            .fontColor('#8FD3E8')
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .margin({ bottom: 6 })
          ForEach(CHECKS, (check: TypeCheck) => {
            Row() {
              Text(check.label)
                .fontSize(11)
                .fontColor('#D6E2E8')
                .layoutWeight(1)
                .textAlign(TextAlign.Start)
              Text(check.value ? 'true' : 'false')
                .fontSize(11)
                .fontWeight(FontWeight.Bold)
                .fontColor(check.value ? '#6FD08C' : '#E06F6F')
            }
            .width('100%')
            .padding({ top: 3, bottom: 3 })
          }, (check: TypeCheck) => check.label)
        }
        .width('100%')
        .padding(12)
        .margin({ top: 12 })
        .borderRadius(12)
        .backgroundColor('#12171B')

        Column() {
          TakeawayCard('One byte, two readings: 200 unsigned = -56 signed. Bytes above 127 flip negative when read signed.')
        }
        .width('100%')
        .margin({ top: 12 })
      }
      .width('100%')
      .margin({ top: 12 })

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
