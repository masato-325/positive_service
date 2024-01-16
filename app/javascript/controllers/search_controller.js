import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.element.addEventListener('turbo:submit-end', this.resetFocus.bind(this))
  }

  resetFocus() {
    // 現在フォーカスされている入力フィールドのIDを取得
    const activeElementId = document.activeElement.id

    // 少し待ってからフォーカスを復元
    setTimeout(() => {
      const activeElement = this.element.querySelector(`#${activeElementId}`)
      activeElement && activeElement.focus()
    }, 0)
  }

  submit() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 200)
  }
}
