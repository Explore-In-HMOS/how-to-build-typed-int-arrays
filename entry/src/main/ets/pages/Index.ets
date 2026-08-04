import LessonRoutes from '../common/constants/LessonRoutes';
import AppNavigator from '../common/util/AppNavigator';
import {
  BytesRouteBuilder,
  ConcatRouteBuilder,
  LessonIndexRouteBuilder,
  PixelsRouteBuilder,
  TextRouteBuilder,
  WidthRouteBuilder
} from './RouteBuilders';

@Entry
@Component
struct Index {
  private pathStack: NavPathStack = new NavPathStack();

  aboutToAppear() {
    AppNavigator.setPathStack(this.pathStack);
  }

  build() {
    Navigation(this.pathStack) {
    }
    .mode(NavigationMode.Stack)
    .hideNavBar(true)
    .navDestination(this.pageMap)
    .onAppear(() => this.seedInitialRoute())
    .width('100%')
    .height('100%')
  }

  @Builder
  private pageMap(name: string) {
    if (name === LessonRoutes.LESSON_INDEX) {
      LessonIndexRouteBuilder();
    } else if (name === LessonRoutes.L1_BYTES) {
      BytesRouteBuilder();
    } else if (name === LessonRoutes.L2_WIDTH) {
      WidthRouteBuilder();
    } else if (name === LessonRoutes.L3_TEXT) {
      TextRouteBuilder();
    } else if (name === LessonRoutes.L4_PIXELS) {
      PixelsRouteBuilder();
    } else if (name === LessonRoutes.L5_CONCAT) {
      ConcatRouteBuilder();
    }
  }

  private seedInitialRoute(): void {
    if (this.pathStack.size() === 0) {
      this.pathStack.pushPath({ name: LessonRoutes.LESSON_INDEX });
    }
  }
}
