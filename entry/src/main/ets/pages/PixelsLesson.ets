import { LengthMetricsUnit } from '@kit.ArkUI';
import { LessonHeader, LessonBackButton } from '../common/components/LessonScaffold';
import { TakeawayCard } from '../common/components/TakeawayCard';
import { brighten, buildGrid, GRID_SIZE, invert } from '../binary/PixelBuffer';

const SCALE: number = 10;
const CANVAS_PX: number = GRID_SIZE * SCALE;

class FilterOption {
  key: string = '';
  label: string = '';

  constructor(key: string, label: string) {
    this.key = key;
    this.label = label;
  }
}

@Component
export struct PixelsLesson {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings, LengthMetricsUnit.PX);
  private options: FilterOption[] = [
    new FilterOption('original', 'Original'),
    new FilterOption('invert', 'Invert'),
    new FilterOption('brighten', 'Brighten +120')
  ];
  @State selected: string = 'original';

  private sourceFor(key: string): Uint8ClampedArray {
    const base: Uint8ClampedArray = buildGrid();
    if (key === 'invert') {
      return invert(base);
    } else if (key === 'brighten') {
      return brighten(base, 120);
    }
    return base;
  }

  // Expand the tiny 16x16 buffer into a display-sized ImageData with integer
  // block scaling. The source buffer stays 16x16 (and its filters); this only
  // enlarges it so the grid is legible on the watch.
  private scaledImageData(source: Uint8ClampedArray): ImageData {
    const out: Uint8ClampedArray = new Uint8ClampedArray(CANVAS_PX * CANVAS_PX * 4);
    for (let y = 0; y < CANVAS_PX; y++) {
      const sy: number = Math.floor(y / SCALE);
      for (let x = 0; x < CANVAS_PX; x++) {
        const sx: number = Math.floor(x / SCALE);
        const si: number = (sy * GRID_SIZE + sx) * 4;
        const di: number = (y * CANVAS_PX + x) * 4;
        out[di] = source[si];
        out[di + 1] = source[si + 1];
        out[di + 2] = source[si + 2];
        out[di + 3] = source[si + 3];
      }
    }
    return new ImageData(CANVAS_PX, CANVAS_PX, out, LengthMetricsUnit.PX);
  }

  private redraw() {
    const image: ImageData = this.scaledImageData(this.sourceFor(this.selected));
    this.context.putImageData(image, 0, 0);
  }

  build() {
    Scroll() {
      Column() {
        LessonHeader('L4 · Pixels')
        this.scaffoldContent()
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

  @Builder
  filterChip(opt: FilterOption) {
    Text(opt.label)
      .fontSize(10)
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
        this.redraw();
      })
  }

  @Builder
  scaffoldContent() {
    Column() {
        Text('A 16×16 RGBA Uint8ClampedArray drawn via ImageData + putImageData.')
          .fontSize(11)
          .fontColor('#9AA6AD')
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ bottom: 12 })

        Canvas(this.context)
          .width(`${CANVAS_PX}px`)
          .height(`${CANVAS_PX}px`)
          .backgroundColor('#000000')
          .borderRadius(8)
          .onReady(() => {
            this.redraw();
          })

        Row() {
          ForEach(this.options, (opt: FilterOption) => {
            this.filterChip(opt)
          }, (opt: FilterOption) => opt.key)
        }
        .width('100%')
        .margin({ top: 14 })

        Column() {
          Text('Brighten adds +120 to each channel. Where a value exceeds 255 it')
            .fontSize(10)
            .fontColor('#9AA6AD')
            .width('100%')
          Text('saturates to 255 (white) — a plain Uint8Array would wrap instead.')
            .fontSize(10)
            .fontColor('#9AA6AD')
            .width('100%')
        }
        .width('100%')
        .padding(12)
        .margin({ top: 12 })
        .borderRadius(12)
        .backgroundColor('#12171B')

        Column() {
          TakeawayCard('Clamped: 200 + 100 stays 255, never wraps.')
        }
        .width('100%')
        .margin({ top: 12 })
      }
      .width('100%')
      .margin({ top: 12 })
  }
}
