import AppNavigator from '../util/AppNavigator';

// Shared lesson chrome as @Builder functions instead of a custom component:
// a content slot cannot be expressed as a global @Builder param, so each page
// owns the Scroll/Column wrapper (matching LessonIndex) and drops in these.

// Round-screen: top corners are not usable, so keep the title short, centered,
// and give it vertical breathing room from the very top.
@Builder
export function LessonHeader(title: string) {
  Blank().height(26)
  Text(title)
    .fontSize(17)
    .fontWeight(FontWeight.Bold)
    .fontColor('#F2F5F7')
    .width('100%')
    .textAlign(TextAlign.Center)
    .maxLines(2)
    .textOverflow({ overflow: TextOverflow.Ellipsis })
}

@Builder
export function LessonBackButton() {
  Button('Back')
    .width('70%')
    .height(34)
    .fontSize(13)
    .fontColor('#F2F5F7')
    .backgroundColor('#2A3138')
    .borderRadius(17)
    .margin({ top: 18, bottom: 24 })
    .onClick(() => {
      AppNavigator.pop();
    })
}
