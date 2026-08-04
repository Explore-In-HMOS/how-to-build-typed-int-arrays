import LessonRoutes from '../constants/LessonRoutes';

export default class AppNavigator {
  private static readonly PATH_STACK_KEY: string = 'appNavPathStack';

  static setPathStack(pathStack: NavPathStack): void {
    AppStorage.setOrCreate<NavPathStack>(AppNavigator.PATH_STACK_KEY, pathStack);
  }

  static push(routeName: string): void {
    const pathStack = AppNavigator.getPathStack();
    if (!pathStack) {
      return;
    }
    pathStack.pushPath({ name: routeName });
  }

  static pop(): void {
    const pathStack = AppNavigator.getPathStack();
    if (!pathStack) {
      return;
    }
    pathStack.pop();
  }

  static clearToIndex(): void {
    const pathStack = AppNavigator.getPathStack();
    if (!pathStack) {
      return;
    }
    pathStack.clear();
    pathStack.pushPath({ name: LessonRoutes.LESSON_INDEX });
  }

  private static getPathStack(): NavPathStack | undefined {
    return AppStorage.get<NavPathStack>(AppNavigator.PATH_STACK_KEY);
  }
}
