document.addEventListener('DOMContentLoaded', (event) => {
  const form = document.getElementById('consultation-form');
  if (form) {
    form.onsubmit = function() {
      const publicStatus = document.getElementById('consultation-public-status').value;
      if (publicStatus === '公開') {
        return confirm('公開されますがよろしいですか？');
      }
      return true;
    };
  }
});
