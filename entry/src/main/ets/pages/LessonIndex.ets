import LessonRoutes from '../common/constants/LessonRoutes';
import AppNavigator from '../common/util/AppNavigator';

class LessonEntry {
  route: string = '';
  title: string = '';
  subtitle: string = '';

  constructor(route: string, title: string, subtitle: string) {
    this.route = route;
    this.title = title;
    this.subtitle = subtitle;
  }
}

const LESSONS: LessonEntry[] = [
  new LessonEntry(LessonRoutes.L1_BYTES, 'L1 · Bytes', 'Signed vs unsigned bytes'),
  new LessonEntry(LessonRoutes.L2_WIDTH, 'L2 · Width & Sign', '16/32-bit views + endianness'),
  new LessonEntry(LessonRoutes.L3_TEXT, 'L3 · Text', 'Bytes decoded to a string'),
  new LessonEntry(LessonRoutes.L4_PIXELS, 'L4 · Pixels', 'Clamped RGBA on canvas'),
  new LessonEntry(LessonRoutes.L5_CONCAT, 'L5 · Concatenate', 'ConcatArray vs typed .set()')
];

@Builder
export function LessonIndexContent() {
  Scroll() {
    Column() {
      Blank().height(26)

      Text('Typed Int Arrays')
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor('#F2F5F7')
        .width('100%')
        .textAlign(TextAlign.Center)

      Text('One buffer, many readings')
        .fontSize(11)
        .fontColor('#9AA6AD')
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 4, bottom: 14 })

      ForEach(LESSONS, (item: LessonEntry) => {
        Column() {
          Text(item.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F2F5F7')
            .width('100%')
            .textAlign(TextAlign.Start)
          Text(item.subtitle)
            .fontSize(11)
            .fontColor('#9AA6AD')
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ top: 2 })
        }
        .width('100%')
        .padding(12)
        .margin({ bottom: 10 })
        .borderRadius(14)
        .backgroundColor('#161B1F')
        .onClick(() => {
          AppNavigator.push(item.route);
        })
      }, (item: LessonEntry) => item.route)

      Blank().height(20)
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
