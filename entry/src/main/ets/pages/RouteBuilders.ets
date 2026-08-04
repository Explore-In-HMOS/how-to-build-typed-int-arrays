import { LessonIndexContent } from './LessonIndex';
import { BytesLessonContent } from './BytesLesson';
import { WidthSignLesson } from './WidthSignLesson';
import { TextLessonContent } from './TextLesson';
import { PixelsLesson } from './PixelsLesson';
import { ConcatLessonContent } from './ConcatLesson';

@Builder
export function LessonIndexRouteBuilder() {
  NavDestination() {
    LessonIndexContent();
  }
  .hideTitleBar(true)
}

@Builder
export function BytesRouteBuilder() {
  NavDestination() {
    BytesLessonContent();
  }
  .hideTitleBar(true)
}

@Builder
export function WidthRouteBuilder() {
  NavDestination() {
    WidthSignLesson();
  }
  .hideTitleBar(true)
}

@Builder
export function TextRouteBuilder() {
  NavDestination() {
    TextLessonContent();
  }
  .hideTitleBar(true)
}

@Builder
export function PixelsRouteBuilder() {
  NavDestination() {
    PixelsLesson();
  }
  .hideTitleBar(true)
}

@Builder
export function ConcatRouteBuilder() {
  NavDestination() {
    ConcatLessonContent();
  }
  .hideTitleBar(true)
}
