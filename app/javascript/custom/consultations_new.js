document.addEventListener('turbo:load', (event) => {
  const form = document.getElementById('consultation-form');
  if (form) {
    form.onsubmit = function() {
      const publicStatus = document.getElementById('consultation-form-public-status').value;
      if (publicStatus === '公開') {
        return confirm('公開されますがよろしいですか？');
      }
      return true;
    };

    const randomizeButton = document.getElementById("randomize-button");
    if (randomizeButton) {
      randomizeButton.addEventListener("click", function() {
        // 性格の選択
        randomSelect("consultation_form_personality");
        // 話し方の選択
        randomSelect("consultation_form_speak_type");
        // 職業の選択
        randomSelect("consultation_form_business");
        // 一人称の選択
        randomSelect("consultation_form_given_name");
        // 年齢の選択
        randomSelect("consultation_form_age");
        // 性別の選択
        randomSelect("consultation_form_gender");
      });
    }
  }

  function randomSelect(elementId) {
    console.log(elementId);
    const select = document.getElementById(elementId);
    if (!select) return; // 要素が見つからない場合は処理をスキップ
    const options = select.options;
    const randomIndex = Math.floor(Math.random() * options.length);
    select.selectedIndex = randomIndex;
  }
});
