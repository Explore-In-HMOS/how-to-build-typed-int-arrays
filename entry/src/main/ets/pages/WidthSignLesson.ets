import { LessonHeader, LessonBackButton } from '../common/components/LessonScaffold';
import { TakeawayCard } from '../common/components/TakeawayCard';
import { asInt16, asInt32, asUint16, asUint32, byteLength, getSharedBuffer } from '../binary/SamplePayload';

class ViewOption {
  key: string = '';
  label: string = '';
  bytesPerElement: number = 0;

  constructor(key: string, label: string, bytesPerElement: number) {
    this.key = key;
    this.label = label;
    this.bytesPerElement = bytesPerElement;
  }
}



@Component
export struct WidthSignLesson {
  private options: ViewOption[] = [
    new ViewOption('int16', 'Int16', 2),
    new ViewOption('uint16', 'Uint16', 2),
    new ViewOption('int32', 'Int32', 4),
    new ViewOption('uint32', 'Uint32', 4)
  ];
  @State selected: string = 'int16';

  private valuesFor(key: string): number[] {
    const out: number[] = [];
    if (key === 'int16') {
      const v: Int16Array = asInt16();
      for (let i = 0; i < v.length; i++) {
        out.push(v[i]);
      }
    } else if (key === 'uint16') {
      const v: Uint16Array = asUint16();
      for (let i = 0; i < v.length; i++) {
        out.push(v[i]);
      }
    } else if (key === 'int32') {
      const v: Int32Array = asInt32();
      for (let i = 0; i < v.length; i++) {
        out.push(v[i]);
      }
    } else {
      const v: Uint32Array = asUint32();
      for (let i = 0; i < v.length; i++) {
        out.push(v[i]);
      }
    }
    return out;
  }

  private bytesPerElementFor(key: string): number {
    for (const opt of this.options) {
      if (opt.key === key) {
        return opt.bytesPerElement;
      }
    }
    return 1;
  }

  static leReading(): number {
    return new DataView(getSharedBuffer()).getInt16(0, true);
  }

  static beReading(): number {
    return new DataView(getSharedBuffer()).getInt16(0, false);
  }

  @Builder
  viewChip(opt: ViewOption) {
    Text(opt.label)
      .fontSize(11)
      .fontWeight(this.selected === opt.key ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.selected === opt.key ? '#08252E' : '#B7C4CB')
      .backgroundColor(this.selected === opt.key ? '#8FD3E8' : '#1B2228')
      .layoutWeight(1)
      .height(30)
      .textAlign(TextAlign.Center)
      .borderRadius(8)
      .margin({ left: 2, right: 2 })
      .onClick(() => {
        this.selected = opt.key;
      })
  }

  @Builder
  valueRow(value: number, i: number) {
    Row() {
      Text(`[${i}]`)
        .fontSize(11)
        .fontColor('#9AA6AD')
        .width('30%')
        .textAlign(TextAlign.Start)
      Text(`${value}`)
        .fontSize(12)
        .fontColor('#EAF6FA')
        .width('70%')
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .border({ width: { bottom: 0.5 }, color: '#1C242A' })
  }

  build() {
    Scroll() {
      Column() {
        LessonHeader('L2 · Width & Sign')

        Column() {
          Text('Same 16 bytes, read at different widths. Wider elements = fewer numbers.')
            .fontSize(11)
            .fontColor('#9AA6AD')
            .width('100%')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 12 })

          Row() {
            ForEach(this.options, (opt: ViewOption) => {
              this.viewChip(opt)
            }, (opt: ViewOption) => opt.key)
          }
          .width('100%')

          Row() {
            Text(`${byteLength()} bytes ÷ ${this.bytesPerElementFor(this.selected)} = `)
              .fontSize(12)
              .fontColor('#D6E2E8')
            Text(`${this.valuesFor(this.selected).length}`)
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#8FD3E8')
            Text(' elements')
              .fontSize(12)
              .fontColor('#D6E2E8')
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: 12, bottom: 8 })

          Column() {
            // Need to use this index.
            // eslint-disable-next-line @performance/foreach-index-check
            ForEach(this.valuesFor(this.selected), (value: number, i: number) => {
              this.valueRow(value, i)
            }, (value: number) => `${this.selected}-${value}`)
          }
          .width('100%')
          .padding(10)
          .borderRadius(12)
          .backgroundColor('#12171B')

          Column() {
            Text('Endianness (bytes 0..1 = C8 00)')
              .fontSize(11)
              .fontColor('#8FD3E8')
              .fontWeight(FontWeight.Medium)
              .width('100%')
              .margin({ bottom: 6 })
            Text('Typed arrays always use the platform order. To pick byte order, read with DataView.')
              .fontSize(10)
              .fontColor('#9AA6AD')
              .width('100%')
              .margin({ bottom: 8 })
            Row() {
              Text('getInt16(0, true) LE')
                .fontSize(11)
                .fontColor('#D6E2E8')
                .layoutWeight(1)
              Text(`${WidthSignLesson.leReading()}`)
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor('#6FD08C')
            }
            .width('100%')
            .padding({ top: 3, bottom: 3 })
            Row() {
              Text('getInt16(0, false) BE')
                .fontSize(11)
                .fontColor('#D6E2E8')
                .layoutWeight(1)
              Text(`${WidthSignLesson.beReading()}`)
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor('#F0A868')
            }
            .width('100%')
            .padding({ top: 3, bottom: 3 })
          }
          .width('100%')
          .padding(12)
          .margin({ top: 12 })
          .borderRadius(12)
          .backgroundColor('#12171B')

          Column() {
            TakeawayCard('Same bytes, wider window → fewer numbers; byte order flips the value.')
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
}
