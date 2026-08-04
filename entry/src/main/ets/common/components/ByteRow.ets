// When signed != unsigned the byte was > 127, so the signed cell is tinted.
@Builder
export function ByteRow(index: number, hex: string, unsignedValue: number, signedValue: number) {
  Row() {
    Text(`${index}`)
      .fontSize(11)
      .fontColor('#9AA6AD')
      .width('16%')
      .textAlign(TextAlign.Start)
    Text(hex)
      .fontSize(11)
      .fontColor('#EAF6FA')
      .width('28%')
      .textAlign(TextAlign.Center)
    Text(`${unsignedValue}`)
      .fontSize(11)
      .fontColor('#8FD3E8')
      .width('28%')
      .textAlign(TextAlign.Center)
    Text(`${signedValue}`)
      .fontSize(11)
      .fontColor(signedValue < 0 ? '#F0A868' : '#8FA0A8')
      .fontWeight(signedValue < 0 ? FontWeight.Bold : FontWeight.Normal)
      .width('28%')
      .textAlign(TextAlign.End)
  }
  .width('100%')
  .padding({ top: 4, bottom: 4 })
  .border({ width: { bottom: 0.5 }, color: '#1C242A' })
}
