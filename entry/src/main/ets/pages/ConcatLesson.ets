import { LessonHeader, LessonBackButton } from '../common/components/LessonScaffold';
import { TakeawayCard } from '../common/components/TakeawayCard';
import { collectionsConcat, typedSetJoin } from '../binary/ConcatDemo';

const COLLECTIONS_RESULT: string = collectionsConcat();
const TYPED_RESULT: string = typedSetJoin();

@Builder
function concatResultPanel(heading: string, code: string, result: string, accent: string) {
  Column() {
    Text(heading)
      .fontSize(11)
      .fontColor(accent)
      .fontWeight(FontWeight.Medium)
      .width('100%')
    Text(code)
      .fontSize(10)
      .fontColor('#9AA6AD')
      .width('100%')
      .margin({ top: 4 })
    Text(result)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor('#EAF6FA')
      .width('100%')
      .textAlign(TextAlign.Center)
      .margin({ top: 8 })
  }
  .width('100%')
  .padding(12)
  .borderRadius(12)
  .backgroundColor('#12171B')
}

@Builder
function concatScaffoldContent() {
  Column() {
      Text('Two ways to join numbers — only one has .concat().')
        .fontSize(11)
        .fontColor('#9AA6AD')
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ bottom: 12 })

      concatResultPanel(
        'collections.Array.concat',
        'a.concat(bc)  // bc: ConcatArray<number>',
        COLLECTIONS_RESULT,
        '#8FD3E8'
      )

      Column() {
        concatResultPanel(
          'Int16Array via allocate + .set()',
          'r = new Int16Array(x.len + y.len); r.set(x,0); r.set(y,x.len)',
          TYPED_RESULT,
          '#6FD08C'
        )
      }
      .width('100%')
      .margin({ top: 12 })

      Column() {
        TakeawayCard('Built-in typed arrays have no .concat(); allocate + .set(). ConcatArray belongs to collections.Array.')
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
    .margin({ top: 12 })
}

@Builder
export function ConcatLessonContent() {
  Scroll() {
    Column() {
      LessonHeader('L5 · Concatenate')
      concatScaffoldContent()
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
