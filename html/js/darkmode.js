const checkbox_mode = document.getElementById("dark_mode_toggle")
const prefersDarkScheme = window.matchMedia("(prefers-color-scheme: dark)");
const local_theme = window.localStorage.getItem('local_theme');

function set_dark_theme() {
  if(!document.body.classList.contains("dark-theme")){
    document.body.classList.add("dark-theme");
  }
  window.localStorage.setItem('local_theme', 'dark');
}

function set_light_theme() {
  if(document.body.classList.contains("dark-theme")){
    document.body.classList.remove("dark-theme");
  }
  window.localStorage.setItem('local_theme', 'light');
}

function init_dark_mode_toggle() {
  document.body.classList.add('notransition'); // Disable transitions
  if(local_theme == 'dark' || prefersDarkScheme.matches) {
    set_dark_theme();
    checkbox_mode.checked = true
  } else if(local_theme == 'light' || !prefersDarkScheme.matches) {
    set_light_theme()
    checkbox_mode.checked = false
  }
  document.body.offsetHeight; // Trigger a reflow, flushing the CSS changes
  document.body.classList.remove('notransition'); // Re-enable transitions
  document.body.style.transition = "1.2s";
}

init_dark_mode_toggle();

function adjust_theme() {
  if(checkbox_mode.checked) {
    set_dark_theme();
  } else {
    set_light_theme();
  }
}

checkbox_mode.addEventListener("click", function () {
  adjust_theme()
});

/*
@licstart  The following is the entire license notice for the JavaScript code in this page.

MIT License

Copyright (c) 2020 various contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

@licend  The above is the entire license notice for the JavaScript code in this page.
*/
