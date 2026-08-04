@Builder
export function TakeawayCard(text: string) {
  Column() {
    Text('TAKEAWAY')
      .fontSize(10)
      .fontColor('#8FD3E8')
      .fontWeight(FontWeight.Medium)
      .width('100%')
    Text(text)
      .fontSize(12)
      .fontColor('#EAF6FA')
      .width('100%')
      .margin({ top: 4 })
  }
  .width('100%')
  .padding(10)
  .borderRadius(12)
  .backgroundColor('#22303A')
}
