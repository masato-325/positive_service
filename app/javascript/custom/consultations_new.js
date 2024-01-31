document.addEventListener('turbo:load', (event) => {
  const form = document.getElementById('consultation-form');
  if (form) {
    form.onsubmit = function() {
      const publicStatus = document.getElementById('consultation-form-public-status').value;
      if (publicStatus === '公開') {
        const isConfirmed = confirm('公開されますがよろしいですか？');
        if (isConfirmed) {
          // ローディング画面を表示
          document.getElementById('loadingScreen').style.display = 'block';
        }
        return isConfirmed;
      }
      // 公開ではない場合もローディング画面を表示
      document.getElementById('loadingScreen').style.display = 'block';
      return true;
    };



    const randomizeButton = document.getElementById("randomize-button");
    if (randomizeButton) {
      randomizeButton.addEventListener("click", function() {
        randomSelect("consultation_form_personality");
        randomSelect("consultation_form_speak_type");
        randomSelect("consultation_form_business");
        randomSelect("consultation_form_given_name");
        randomSelect("consultation_form_age");
        randomSelect("consultation_form_gender");
      });
    }
    const sisterButton = document.getElementById("sister-button");
    if (sisterButton) {
      sisterButton.addEventListener("click", function() {
        setSelectValue("consultation_form_name", "お姉ちゃん");
        setSelectValue("consultation_form_personality", "優しい");
        setSelectValue("consultation_form_speak_type", "関西弁");
        setSelectValue("consultation_form_business", "姉");
        setSelectValue("consultation_form_given_name", "うち");
        setSelectValue("consultation_form_age", "20代");
        setSelectValue("consultation_form_gender", "女性");
      });
    }

    const brotherButton = document.getElementById("brother-button");
    if (brotherButton) {
      brotherButton.addEventListener("click", function() {
        setSelectValue("consultation_form_name", "お兄ちゃん");
        setSelectValue("consultation_form_personality", "クレイジー");
        setSelectValue("consultation_form_speak_type", "高圧的");
        setSelectValue("consultation_form_business", "兄");
        setSelectValue("consultation_form_given_name", "俺");
        setSelectValue("consultation_form_age", "20代");
        setSelectValue("consultation_form_gender", "男性");
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

  function setSelectValue(elementId, value) {
    const select = document.getElementById(elementId);
    if (!select) return; // 要素が見つからない場合は処理をスキップ
    select.value = value;
  }
});