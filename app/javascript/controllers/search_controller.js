// app/javascript/controllers/search_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // turbo:load イベントが発生したときに resetFocus メソッドを呼び出す
    document.addEventListener('turbo:load', this.resetFocus.bind(this))
  }

  resetFocus() {
    // 前回フォーカスされていた要素のIDを取得
    const activeElementId = document.activeElement.id;

    // IDが存在し、要素を取得できた場合にフォーカスを設定
    if (activeElementId) {
      const activeElement = this.element.querySelector(`#${activeElementId}`);
      activeElement && activeElement.focus();
    }
  }

  // 200ミリ秒間入力がなければ送信
  submit() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 200)
  }
}
